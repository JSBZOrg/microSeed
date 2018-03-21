import { router, get, post, put } from 'microrouter'
import { login, register, resetPsd } from './api/login'
import { createUser } from './api/user'

export default router(
  # login
  post '/signup', register
  post '/login', login
  put '/resetPsd', resetPsd
  # user
  post '/user', createUser
)
