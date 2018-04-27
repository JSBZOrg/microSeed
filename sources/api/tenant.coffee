import { json } from 'micro'
import services from '../services/leancloud'
import { judgeIsVerify } from '../utils/helper'

createTenant = (req, res) =>
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
      await services.Tenants.create {
        body...
        personId
      }
  catch error
    console.log error()

fetchTenant = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Tenants.fetch body
  catch error
    console.log error()

export {
  createTenant
  fetchTenant
}