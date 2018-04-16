import { router, get, post, put, del } from 'microrouter'
import { login, register, resetPsd } from './api/login'
import { reloadUser, createUser, fetchUser, updateUser, deleteUser, findUserWithIDCard } from './api/user'
import { createLandlord, findLdwithIDCard } from './api/landlord'
import { createHouse } from './api/house'
import { createRoom } from './api/room'
import { createBed } from './api/bed'

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
  get '/user/link/:IDCard', findUserWithIDCard
  # landlord
  get '/landlord/link/:IDCard', findLdwithIDCard
  post '/landlord', createLandlord
  # house
  post '/house', createHouse
  # room
  post '/room', createRoom
  # bed
  post '/bed', createBed
)
