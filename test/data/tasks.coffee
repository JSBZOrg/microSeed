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

  await each houses
  , (house) =>
    try
      # 通过IDCard查找是否存在该房东
      landlord_data = await services.Special.findLandlordWithIDCard {
        token: user.token
        IDCard: house.landlord.IDCard
      }
      # # 通过IDCard查找是否存在该授权人
      # authorizer_data = await services.Special.findLandlordWithIDCard {
      #   token: user.token
      #   IDCard: house.authorizer.IDCard
      # }
      # # 通过IDCard查找是否存在该结款人
      # payee_data = await services.Special.findLandlordWithIDCard {
      #   token: user.token
      #   IDCard: house.payee.IDCard
      # }
      # # Promise.all方法
      # Promise.all([landlord_data, authorizer_data, payee_data])
      #   .then (results) =>
      #     console.log results
      #     # results.forEach (result) =>
      #     #   console.log result
      #   .catch (error) =>
      #     dd error

      # 如果存在则将landlord属性换为landlordId属性
      if landlord_data?.results? and landlord_data.results.length >= 1
        delete house.landlord
        house.landlordId = landlord_data.results[0].objectId
        params = house
        await services.house.create {
          token: user.token
          params...
        }
      else
        # 不存在的情况下先新建该房东再将landlord属性改为landlordId属性
        params = house.landlord
        landlordData = await services.landlord.create {
          token: user.token
          params...
        }
        if landlordData?.objectId?
          delete house.landlord
          house.landlordId = landlordData.objectId
          params = house
          await services.house.create {
            token: user.token
            params...
          }
    catch error
      dd error()