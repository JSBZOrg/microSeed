import { json } from 'micro'
import services from '../services/leancloud'
import { judgeIsVerify } from '../utils/helper'

createBed = (req, res) =>
  body = await json req
  if body?.token? and judgeIsVerify(body.token) is true
    delete body.token
    await services.Beds.create body

reloadBed = (req, res) =>
  body = await json req
  if body?.token? and judgeIsVerify(body.token) is true
    delete body.token
    await services.Beds.reload body

findBedWithRoom = (req, res) =>
  body = await json req
  if body?.token? and judgeIsVerify(body.token) is true
    delete body.token
    await services.Special.findBedWithRoom body

export {
  createBed
  reloadBed
  findBedWithRoom
}