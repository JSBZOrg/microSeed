import { json } from 'micro'
import services from '../services/leancloud'
import { judgeIsVerify } from '../utils/helper'

createLandlord = (req, res) =>
  try
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
  catch error
    console.log error()

findLdwithIDCard = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Special.findLandlordWithIDCard body
  catch error
    console.log error()

reloadLandlord = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Landlords.reload body
  catch error
    console.log error()

fetchLandlord = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Landlords.fetch body
  catch error
    console.log error()

export {
  createLandlord
  findLdwithIDCard
  reloadLandlord
  fetchLandlord
}