import 'shelljs/make'
import dd from 'ddeyes'
import fs from 'fs'
import houses from './houses'
import landlord from './landlord'
import services from '../../sources/services/local'
import { each } from 'awaity/esm'

target.all = =>
  # dd 'hello, world'
  await services.Login.login 
    username: '何文涛'
    password: '123456'

target.landlord = =>
  dd landlord

# 一键导入数据 注: leancloud有数据导入导出的功能
target.houses = =>

  await services.Login.register {
    username: '何文涛'
    password: '123456'
  }

  user = await services.Login.login {
    username: '何文涛'
    password: '123456'
  }

  findLandlordFunc = ({token, IDCard}) =>
    await services.Special.findLandlordWithIDCard {
      token: token
      IDCard: IDCard
    }

  createLandlordFunc = ({token, params}) =>
    await services.landlord.create {
      token: token
      params...
    }

  findFunc = ({token, IDCard}) =>
    await services.Special.findUserWithIDCard {
      token: token
      IDCard: IDCard
    }
  
  createFunc = ({token, params}) =>
    await services.user.create {
      token: token
      params...
    }

  await each houses
  , (house) =>
    try
      # 查找是否存在其他房东    
      house.otherLandlord.forEach (iterm) =>
        otherLandlord_data = await findLandlordFunc {
          token: user.token
          IDCard: iterm.IDCard
        }
        if otherLandlord_data?.results? and otherLandlord_data.results.length >= 1
          index = house.otherLandlord.indexOf iterm
          house.otherLandlord[index] = otherLandlord_data.results[0].objectId
        else
          # 不存在走新建逻辑
          data = await createLandlordFunc {
            token: user.token
            params: iterm
          }
          if data?.objectId?
            index = house.otherLandlord.indexOf iterm
            house.otherLandlord[index] = data.objectId
            
      # 查找是否存在授权人
      authorizer_data = await findFunc {
        token: user.token
        IDCard: house.authorizer.IDCard
      }
      if authorizer_data?.results? and authorizer_data.results.length >= 1
        delete house.authorizer
        house.authorizerId = authorizer_data.results[0].objectId
      else
        # 不存在授权人走新建逻辑
        params = house.authorizer
        data = await createFunc {
          token: user.token
          params: params
        }
        if data?.objectId?
          delete house.authorizer
          house.authorizerId = data.objectId
    
      # 查找是否存在结款人
      payee_data = await findFunc {
        token: user.token
        IDCard: house.payee.IDCard
      }
      if payee_data?.results? and payee_data.results.length >= 1
        delete house.payee
        house.payeeId = payee_data.results[0].objectId
      else
        # 不存在结款人走新建逻辑
        params = house.payee
        data = await createFunc {
          token: user.token
          params: params
        }
        if data?.objectId?
          delete house.payee
          house.payeeId = data.objectId

      # 查找是否存在房东
      landlord_data = await findLandlordFunc {
        token: user.token
        IDCard: house.landlord.IDCard
      }
      if landlord_data?.results? and landlord_data.results.length >= 1
        delete house.landlord
        house.landlordId = landlord_data.results[0].objectId
        params = house
        await services.house.create {
          token: user.token
          params...
        }
      else
        # 不存在房东走新建逻辑
        params = house.landlord
        data = await createLandlordFunc {
          token: user.token
          params: params
        }
        if data?.objectId?
          tempHouseData = JSON.parse JSON.stringify house
          delete house.landlord
          delete house.beds
          delete house.room
          house.landlordId = data.objectId
          # 创建house
          house_data = await services.house.create {
            token: user.token
            house...
          }
          # 创建room
          tempHouseData.room.forEach (room) =>
            params = {
              houseId: house_data.objectId
              room...
            }
            room_data = await services.room.create {
              token: user.token
              params...
            }
            # 创建bed
            tempHouseData.beds.forEach (bed) =>
              bedTemp = JSON.parse JSON.stringify bed              
              # 先创建房客
              tenant = bed.tenant
              if Object.keys(tenant).length isnt 0
                tenant_data = await services.tenant.create {
                  token: user.token
                  tenant...
                }
                if tenant_data?.objectId?
                  bedTemp.tenantId = tenant_data.objectId
                  delete bedTemp.tenant
                  # 创建bed
                  params = {
                    roomId: room_data.objectId
                    bedTemp...
                  }
                  await services.bed.create {
                    token: user.token
                    params...
                  }
              else
                bedTemp.tenantId = ''
                delete bedTemp.tenant
                # 创建bed
                params = {
                  roomId: room_data.objectId
                  bedTemp...
                }
                await services.bed.create {
                  token: user.token
                  params...
                }


    catch error
      dd error()

# 数据导出
target.out = =>

  deleteFunc = (jsonData) =>
    {
      others...
      landlordId
      updatedAt
      objectId
      createdAt
      personId
      payeeId
      authorizerId
      houseId
      roomId
      tenantId
    } = jsonData
    others

  # 判断 data文件夹下面是否存在json文件如果没有则创建
  await fs.exists "../data/json"
  , (exists) =>
    unless exists
      await fs.mkdir "../data/json"
      , 0o0777
      , (err) =>
        if err
          dd err

  try
    # 登录
    user = await services.Login.login 
      username: '何文涛'
      password: '123456'
    
    # 找到所有房东
    landlordResults = await services.landlord.reload
      token: user.token

    allTemp = []

    # 找到房东下的房源
    await Promise.all landlordResults.results.map (iterm) =>

      houseResults = await services.Special.findHouseWithLandlord
        token: user.token
        landlordId: iterm.objectId

      # 要将房源相应的授权人、其他房东、结款人的信息关联查询出来
      # otherLandlord  payeeId  authorizerId
      await Promise.all houseResults.results.map (house) =>

        house_temp = JSON.parse JSON.stringify house
        
        # 找到其他房东的关联信息
        await Promise.all house.otherLandlord.map (otherLd) =>

          otherLdResults = await services.landlord.fetch
            token: user.token
            objectId: otherLd

          otherLd_temp = JSON.parse JSON.stringify otherLdResults
          otherLd_temp = deleteFunc otherLd_temp
          house_temp.otherLandlord = otherLd_temp
          
        # 找到授权人的关联信息
        authorizerResults = await services.user.fetch
          token: user.token
          objectId: house.authorizerId

        authorizer_temp = JSON.parse JSON.stringify authorizerResults
        authorizer_temp = deleteFunc authorizer_temp
        house_temp.authorizer = authorizer_temp     

        # 找到结款人的关联信息
        paeeResults = await services.user.fetch
          token: user.token
          objectId: house.payeeId

        paee_temp = JSON.parse JSON.stringify paeeResults
        paee_temp = deleteFunc paee_temp       
        house_temp.payee = paee_temp
        
        # 找到房源下的房间
        roomResults = await services.Special.findRoomWithHouse
          token: user.token
          houseId: house.objectId

        room_temp = JSON.parse JSON.stringify roomResults.results
        
        await Promise.all room_temp.map (roomIterm) =>
          roomIterm = deleteFunc roomIterm
        # room_temp.forEach (roomIterm) =>
        #   roomIterm = deleteFunc roomIterm
        house_temp.room = room_temp

        # 找到房间下的床位
        await Promise.all roomResults.results.map (room) =>

          bedResults = await services.Special.findBedWithRoom
            token: user.token
            roomId: room.objectId

          bed_temp = JSON.parse JSON.stringify bedResults.results
          
          await Promise.all bed_temp.map (bedIterm) =>
            # 找到床位关联的用户
            tenantData = await services.tenant.fetch
              token: user.token
              objectId: bedIterm.tenantId

            if tenantData? and tenantData is  ''
              tenantData = {}
            tenantData = deleteFunc tenantData
            bedIterm = deleteFunc bedIterm            
            bedIterm.tenant = tenantData
            
          await Promise.all house_temp.room.map (roomData) =>
            roomData.beds = bed_temp
            # house_temp = deleteFunc house_temp
            iterm = deleteFunc iterm
            house_temp.landlord = iterm
            house_temp = deleteFunc house_temp

          allTemp.push house_temp

    dd allTemp
    # allTemp.forEach (eachTemp, index) ->
    #   fs.writeFile "json/house#{index+1}.json"
    #   , 
    #     JSON.stringify eachTemp, null, 2
    #   , (err) =>
    #     if err
    #       dd err

  catch error
    if typeof error is 'function'
      dd error()
    else
      dd error   



target.put = =>
  # 创建用户
  # await services.Login.register
  #   username: '何文涛'
  #   password: '123456'
  
  # 用户登录
  user = await services.Login.login
    username: '何文涛'
    password: '123456'

  # 创建房东函数
  createLandlord = (params) =>
    if params? and Object.keys(params).length > 0
      result = await services.landlord.create {
        token: user.token
        params...
      }
      objectId = result.objectId
    else
      objectId = ''
  
  # 创建房源函数
  createHouse = (params) =>
    await services.house.create {
      token: user.token
      params...
    }

  # 读取文件函数
  readfile = (startPath, callback) =>
    allJsonData = []      
    fs.readdir startPath
    , (err, paths) =>
      if err
        dd err
      else
        paths.forEach (path) =>
          fs.readFile "#{startPath}/#{path}"
          , (err, data) =>
            if err
              dd err
            else
              jsonObj = JSON.parse data
              allJsonData.push jsonObj
              callback allJsonData

  readfile './json', (files) =>
    await Promise.all files.map (file) =>
      # 新建房东
      ldResult = await createLandlord file.landlord
      # 新建其他房东
      otherldResult = await createLandlord file.otherLandlord
      # 新建房源
      houseResult = await createHouse {
        file...
        landlordId: ldResult
        otherLandlordId: otherldResult
      }

