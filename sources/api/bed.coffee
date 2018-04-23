import { json } from 'micro'
import services from '../services/leancloud'
import { judgeIsVerify } from '../utils/helper'

createBed = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Beds.create body
  catch error
    console.log error()

reloadBed = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Beds.reload body
  catch error
    console.log error()

findBedWithRoom = (req, res) =>
  try
    body = await json req
    if body?.token? and judgeIsVerify(body.token) is true
      delete body.token
      await services.Special.findBedWithRoom body
  catch error
    console.log error()

export {
  createBed
  reloadBed
  findBedWithRoom
}