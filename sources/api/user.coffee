import { json, send } from 'micro'
import services from '../services/leancloud'
import { judgeIsVerify } from '../utils/helper'

createUser = (req, res) =>
  body = await json req
  if body?.token? and judgeIsVerify(body.token) is true
    delete body.token
    await services.Person.create body

fetchUser = (req, res) =>
  body = await json req
  if body?.token? and judgeIsVerify(body.token) is true
    await services.Person.fetch {
      objectId: body.objectId
    }

updateUser = (req, res) =>
  body = await json req
  if body?.token? and judgeIsVerify(body.token) is true
    delete body.token
    await services.Person.update body

deleteUser = (req, res) =>
  body = await json req
  if body?.token? and judgeIsVerify(body.token) is true
    await services.Person.delete {
      objectId: body.objectId
    }

reloadUser = (req, res) =>
  body = await json req
  if body?.token? and judgeIsVerify(body.token) is true
    await services.Person.reload()

export {
  createUser
  fetchUser
  updateUser
  deleteUser
  reloadUser
}