// Generated by CoffeeScript 2.2.4
var createHouse, findHouseWithLandlord;

import {
  json,
  send
} from 'micro';

import services from '../services/leancloud';

import {
  judgeIsVerify
} from '../utils/helper';

createHouse = async(req, res) => {
  var body, error;
  try {
    body = (await json(req));
    if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
      delete body.token;
      return (await services.Houses.create(body));
    }
  } catch (error1) {
    error = error1;
    return console.log(error());
  }
};

findHouseWithLandlord = async(req, res) => {
  var body, error;
  try {
    body = (await json(req));
    if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
      delete body.token;
      return (await services.Special.findHouseWithLandlord(body));
    }
  } catch (error1) {
    error = error1;
    return console.log(error());
  }
};

export {
  createHouse,
  findHouseWithLandlord
};
