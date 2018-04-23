import { json, send } from 'micro'
import services from '../services/leancloud'
import { judgeIsVerify } from '../utils/helper'

createHouse = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Houses.create body
  catch error
    console.log error()
  
findHouseWithLandlord = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Special.findHouseWithLandlord body
  catch error
    console.log error()

export {
  createHouse
  findHouseWithLandlord
}