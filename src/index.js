// Generated by CoffeeScript 2.2.4
import {
  router,
  get,
  post,
  put,
  del
} from 'microrouter';

import {
  login,
  register,
  resetPsd
} from './api/login';

import {
  reloadUser,
  createUser,
  fetchUser,
  updateUser,
  deleteUser,
  findUserWithIDCard
} from './api/user';

import {
  createLandlord,
  findLdwithIDCard
} from './api/landlord';

import {
  createHouse
} from './api/house';

import {
  createRoom
} from './api/room';

import {
  createBed
} from './api/bed';

// login
// user
// landlord
// house
// room
// bed
export default router(post('/signup', register), post('/login', login), put('/resetPsd', resetPsd), get('/user', reloadUser), post('/user', createUser), get('/user/:objectId', fetchUser), put('/user/:objectId', updateUser), del('/user/:objectId', deleteUser), get('/user/link/:IDCard', findUserWithIDCard), get('/landlord/link/:IDCard', findLdwithIDCard), post('/landlord', createLandlord), post('/house', createHouse), post('/room', createRoom), post('/bed', createBed));
