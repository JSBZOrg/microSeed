import { json } from 'micro'
import services from '../services/leancloud'
import { judgeIsVerify } from '../utils/helper'

createUser = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Person.create body
  catch error
    console.log error()

fetchUser = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      await services.Person.fetch {
        objectId: body.objectId
      }
  catch error
    console.log error()

updateUser = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Person.update body
  catch error
    console.log error()

deleteUser = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      await services.Person.delete {
        objectId: body.objectId
      }
  catch error
    console.log error()

reloadUser = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      await services.Person.reload()
  catch error
    console.log error()

findUserWithIDCard = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      await services.Special.findUserWithIDCard body
  catch error
    console.log error()

export {
  createUser
  fetchUser
  updateUser
  deleteUser
  reloadUser
  findUserWithIDCard
}