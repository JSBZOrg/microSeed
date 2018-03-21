// Generated by CoffeeScript 2.2.2
var createUser;

import {
  json,
  send
} from 'micro';

import services from '../services/leancloud';

createUser = async(req, res) => {
  var body, result;
  body = (await json(req));
  return result = (await services.Person.create(body));
};

export {
  createUser
};