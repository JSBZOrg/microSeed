// Generated by CoffeeScript 2.2.2
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
  createUser,
  fetchUser,
  updateUser,
  deleteUser
} from './api/user';

// login
// user
export default router(post('/signup', register), post('/login', login), put('/resetPsd', resetPsd), post('/user', createUser), get('/user/:objectId', fetchUser), put('/user/:objectId', updateUser), del('/user/:objectId', deleteUser));
