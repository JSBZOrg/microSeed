import { json, send } from 'micro'
import services from '../services/leancloud'
import { verifyToken, refreshToken, generateToken } from '../../sources/utils/helper'

register = (req, res) =>
  body = await json req
  isDelete = false
  username = body.username
  try
    loginData = await services.Login.login {
      username: body.username
      password: body.password
    }
  catch e
    code = e.e.e.e.data.code
    if code isnt 200 and code isnt 219
      personResult = await services.Person.create { username, isDelete }
      personId = personResult.objectId
      result = await services.Login.register {
        body...
        personId
      }

login = (req, res) =>
  body = await json req
  try
    user = await services.Login.login {
      username: body.username
      password: body.password
    }
  catch e
    message: e()

  # 生成token
  token = generateToken(
    user.objectId
    user.sessionToken
  )

  # 对返回的数据进行处理干掉敏感信息
  if user?.objectId?
    delete user.objectId
  if user?.sessionToken?
    delete user.sessionToken
  if user?.updatedAt?
    delete user.updatedAt
  if user?.createdAt?
    delete user.createdAt

  # 返回的数据
  return {
    user
    token
  }
    
resetPsd = (req, res) =>
  body = await json req
  result = await services.Login.resetPsd body
  

export {
  login
  register
  resetPsd
}