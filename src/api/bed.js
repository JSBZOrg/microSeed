// Generated by CoffeeScript 2.2.4
var createBed, reloadBed;

import {
  json
} from 'micro';

import services from '../services/leancloud';

import {
  judgeIsVerify
} from '../utils/helper';

createBed = async(req, res) => {
  var body;
  body = (await json(req));
  if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
    delete body.token;
    return (await services.Beds.create(body));
  }
};

reloadBed = async(req, res) => {
  var body;
  body = (await json(req));
  if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
    delete body.token;
    return (await services.Beds.reload(body));
  }
};

export {
  createBed,
  reloadBed
};