import { router, get, post, put, del } from 'microrouter'
import { login, register, resetPsd } from './api/login'
import { reloadUser, createUser, fetchUser, updateUser, deleteUser } from './api/user'

export default router(
  # login
  post '/signup', register
  post '/login', login
  put '/resetPsd', resetPsd
  # user
  get '/user', reloadUser
  post '/user', createUser
  get '/user/:objectId', fetchUser
  put '/user/:objectId', updateUser
  del '/user/:objectId', deleteUser
)
