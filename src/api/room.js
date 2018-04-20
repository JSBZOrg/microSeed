// Generated by CoffeeScript 2.2.4
var createRoom, findRoomWithHouse;

import {
  json,
  send
} from 'micro';

import services from '../services/leancloud';

import {
  judgeIsVerify
} from '../utils/helper';

createRoom = async(req, res) => {
  var body;
  body = (await json(req));
  if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
    delete body.token;
    return (await services.Rooms.create(body));
  }
};

findRoomWithHouse = async(req, res) => {
  var body;
  body = (await json(req));
  if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
    delete body.token;
    return (await services.Special.findRoomWithHouse(body));
  }
};

export {
  createRoom,
  findRoomWithHouse
};