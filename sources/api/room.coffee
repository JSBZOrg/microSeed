import { json, send } from 'micro'
import services from '../services/leancloud'
import { judgeIsVerify } from '../utils/helper'

createRoom = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Rooms.create body
  catch error
    console.log error()

findRoomWithHouse = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Special.findRoomWithHouse body
  catch error
    console.log error()

reloadRoom = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Rooms.reload body
  catch error
    console.log error()

export {
  createRoom
  reloadRoom
  findRoomWithHouse
}