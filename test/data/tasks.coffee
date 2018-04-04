import 'shelljs/make'
import dd from 'ddeyes'
import urlencode from 'urlencode'
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
      data = await services.Special.findLandlordWithIDCard {
        token: user.token
        IDCard: house.landlord.IDCard
      }
      # 如果存在则将landlord属性换为landlordId属性
      if data?.results? and data.results.length >= 1
        delete house.landlord
        house.landlordId = data.results[0].objectId
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
      dd error