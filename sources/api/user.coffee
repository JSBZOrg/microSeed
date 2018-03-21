import { json, send } from 'micro'
import services from '../services/leancloud'

createUser = (req, res) =>
  body = await json req
  result = await services.Person.create body

export {
  createUser
}