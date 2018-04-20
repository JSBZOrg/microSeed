import { json, send } from 'micro'
import services from '../services/leancloud'
import { judgeIsVerify } from '../utils/helper'

createRoom = (req, res) =>
  body = await json req
  if body?.token? and judgeIsVerify(body.token) is true
    delete body.token
    await services.Rooms.create body

findRoomWithHouse = (req, res) =>
  body = await json req
  if body?.token? and judgeIsVerify(body.token) is true
    delete body.token
    await services.Special.findRoomWithHouse body

export {
  createRoom
  findRoomWithHouse
}