import { json } from 'micro'
import services from '../services/leancloud'
import { judgeIsVerify } from '../utils/helper'

createLandlord = (req, res) =>
  body = await json req
  if body?.token? and judgeIsVerify(body.token) is true
    delete body.token
    isDelete = false
    personData = await services.Person.create {
      body...
      isDelete
    }
    personId = personData.objectId
    await services.Landlords.create {
      body...
      personId
    }

findLdwithIDCard = (req, res) =>
  body = await json req
  if body?.token? and judgeIsVerify(body.token) is true
    delete body.token
    await services.Special.findLandlordWithIDCard body

export {
  createLandlord
  findLdwithIDCard
}