import 'shelljs/make'
import dd from 'ddeyes'
import houses from './houses'
import landlord from './landlord'
import services from '../../sources/services/local'

import { each } from 'awaity/esm'

target.all = =>
  dd 'hello, world'

target.landlord = =>
  dd landlord

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
      house.otherLandlord.forEach (iterm) =>
        # 查找是否存在其他房东
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
          delete house.landlord
          house.landlordId = data.objectId
          params = house
          await services.house.create {
            token: user.token
            params...
          }

    catch error
      dd error