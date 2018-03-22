import { json, send } from 'micro'
import services from '../services/leancloud'

createUser = (req, res) =>
  body = await json req
  result = await services.Person.create body

fetchUser = (req, res) =>
  result = await services.Person.fetch {
    objectId: req.params.objectId
  }

updateUser = (req, res) =>
  body = await json req
  result = await services.Person.update body

deleteUser = (req, res) =>
  result = await services.Person.delete {
    objectId: req.params.objectId
  }

reloadUser = () =>
  result = await services.Person.reload()

export {
  createUser
  fetchUser
  updateUser
  deleteUser
  reloadUser
}