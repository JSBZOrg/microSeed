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
  findLdwithIDCard,
  reloadLandlord,
  fetchLandlord
} from './api/landlord';

import {
  createHouse,
  findHouseWithLandlord
} from './api/house';

import {
  createRoom,
  reloadRoom,
  findRoomWithHouse
} from './api/room';

import {
  createBed,
  reloadBed,
  findBedWithRoom
} from './api/bed';

// login
// user
// landlord
// house
// room
// bed
export default router(post('/signup', register), post('/login', login), put('/resetPsd', resetPsd), get('/user', reloadUser), post('/user', createUser), get('/user/:objectId', fetchUser), put('/user/:objectId', updateUser), del('/user/:objectId', deleteUser), get('/user/link/:IDCard', findUserWithIDCard), get('/landlord/link/:IDCard', findLdwithIDCard), get('/landlord/:objectId', fetchLandlord), get('/landlord', reloadLandlord), post('/landlord', createLandlord), post('/house', createHouse), get('/house/link/:landlordId', findHouseWithLandlord), post('/room', createRoom), get('/room', reloadRoom), get('/room/link/:houseId', findRoomWithHouse), post('/bed', createBed), get('/bed', reloadBed), get('/bed/link/:roomId', findBedWithRoom));
