// Generated by CoffeeScript 2.2.4
var createTenant, fetchTenant,
  _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

import {
  json
} from 'micro';

import services from '../services/leancloud';

import {
  judgeIsVerify
} from '../utils/helper';

createTenant = async(req, res) => {
  var body, error, isDelete, personData, personId;
  try {
    body = (await json(req));
    if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
      delete body.token;
      isDelete = false;
      personData = (await services.Person.create(_extends({}, body, {isDelete})));
      personId = personData.objectId;
      return (await services.Tenants.create(_extends({}, body, {personId})));
    }
  } catch (error1) {
    error = error1;
    return console.log(error());
  }
};

fetchTenant = async(req, res) => {
  var body, error;
  try {
    body = (await json(req));
    if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
      delete body.token;
      return (await services.Tenants.fetch(body));
    }
  } catch (error1) {
    error = error1;
    return console.log(error());
  }
};

export {
  createTenant,
  fetchTenant
};
