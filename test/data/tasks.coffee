import 'shelljs/make'
import dd from 'ddeyes'
import fs from 'fs'
import houses from './houses'
import landlord from './landlord'
import services from '../../sources/services/local'

import { each } from 'awaity/esm'

target.all = =>
  dd 'hello, world'

target.landlord = =>
  dd landlord

# 一键导入数据 注: leancloud有数据导入导出的功能
target.houses = =>

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
              params = {
                roomId: room_data.objectId
                bed...
              }
              await services.bed.create {
                token: user.token
                params...
              }

    catch error
      dd error

# 数据导出
target.out = =>
  # 封装delete方法
  deleteFunc = (jsonData) =>
    if jsonData?.landlordId?
      delete jsonData.landlordId
    if jsonData?.updatedAt?
      delete jsonData.updatedAt
    if jsonData?.objectId?
      delete jsonData.objectId
    if jsonData?.createdAt?
      delete jsonData.createdAt
    if jsonData?.personId?
      delete jsonData.personId
    if jsonData?.payeeId?
      delete jsonData.payeeId
    if jsonData?.authorizerId?
      delete jsonData.authorizerId
    if jsonData?.houseId?
      delete jsonData.houseId
    if jsonData?.roomId?
      delete jsonData.roomId
    return jsonData

  # 登录
  user = await services.Login.login {
    username: '何文涛'
    password: '123456'
  }
  
  # 找到所有房东
  landlordResults = await services.landlord.reload {
    token: user.token
  }
  
  # 计算总共有多少房源
  roomTotal = await services.room.reload {
    token: user.token
  }

  allTemp = []
  
  # 找到房东下的房源
  landlordResults.results.forEach (iterm) =>
    houseResults = await services.Special.findHouseWithLandlord {
      token: user.token
      landlordId: iterm.objectId
    }
    # 要将房源相应的授权人、其他房东、结款人的信息关联查询出来
    # otherLandlord  payeeId  authorizerId
    houseResults.results.forEach (house) =>
      house_temp = JSON.parse JSON.stringify house
      
      # 找到其他房东的关联信息
      house.otherLandlord.forEach (otherLd) =>
        otherLdResults = await services.landlord.fetch {
          token: user.token
          objectId: otherLd
        } 
        otherLd_temp = JSON.parse JSON.stringify otherLdResults
        deleteFunc(otherLd_temp)
        house_temp.otherLandlord = otherLd_temp
        
      # 找到授权人的关联信息
      authorizerResults = await services.user.fetch {
        token: user.token
        objectId: house.authorizerId
      }
      authorizer_temp = JSON.parse JSON.stringify authorizerResults
      deleteFunc(authorizer_temp)
      house_temp.authorizer = authorizer_temp      

      # 找到结款人的关联信息
      paeeResults = await services.user.fetch {
        token: user.token
        objectId: house.payeeId
      }
      paee_temp = JSON.parse JSON.stringify paeeResults
      deleteFunc(paee_temp)      
      house_temp.payee = paee_temp
      
      # 找到房源下的房间
      roomResults = await services.Special.findRoomWithHouse {
        token: user.token
        houseId: house.objectId
      }
      room_temp = JSON.parse JSON.stringify roomResults.results
      room_temp.forEach (roomIterm) =>
        deleteFunc(roomIterm)      
      house_temp.room = room_temp

      # 找到房间下的床位
      roomResults.results.forEach (room) =>
        bedResults = await services.Special.findBedWithRoom {
          token: user.token
          roomId: room.objectId
        }
        bed_temp = JSON.parse JSON.stringify bedResults.results
        bed_temp.forEach (bedIterm) =>
          deleteFunc(bedIterm)

        house_temp.room.forEach (roomData) =>
          roomData.beds = bed_temp

          deleteFunc(house_temp)
          deleteFunc(iterm)        
          house_temp.landlord = iterm

        allTemp.push(house_temp)
        
        # 判断 data文件夹下面是否存在json文件如果没有则创建
        fs.exists("../data/json", (exists) =>
          if not exists
            fs.mkdir("../data/json", 0o0777, (err) =>
              if err
                dd err
            )
          else
            allTemp.forEach (eachTemp, index) =>
              fs.writeFile("json/house#{index+1}.json", JSON.stringify(eachTemp, null, 4), (err) =>
                if err
                  dd err
              )
        )  
         