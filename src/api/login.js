// Generated by CoffeeScript 2.2.3
var login, register, resetPsd,
  _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

import {
  json,
  send
} from 'micro';

import services from '../services/leancloud';

import {
  verifyToken,
  refreshToken,
  generateToken
} from '../../sources/utils/helper';

register = async(req, res) => {
  var body, code, e, isDelete, loginData, personId, personResult, result, username;
  console.log('req---->>', req);
  body = (await json(req));
  console.log('hjhdjf--->>', body);
  isDelete = false;
  username = body.username;
  try {
    return loginData = (await services.Login.login({
      username: body.username,
      password: body.password
    }));
  } catch (error) {
    e = error;
    code = e.e.e.e.data.code;
    if (code !== 200 && code !== 219) {
      personResult = (await services.Person.create({username, isDelete}));
      personId = personResult.objectId;
      return result = (await services.Login.register(_extends({}, body, {personId})));
    }
  }
};

login = async(req, res) => {
  var body, e, token, user;
  body = (await json(req));
  try {
    user = (await services.Login.login({
      username: body.username,
      password: body.password
    }));
  } catch (error) {
    e = error;
    ({
      message: e()
    });
  }
  // 生成token
  token = generateToken(user.objectId, user.sessionToken);
  // 对返回的数据进行处理干掉敏感信息
  if ((user != null ? user.objectId : void 0) != null) {
    delete user.objectId;
  }
  if ((user != null ? user.sessionToken : void 0) != null) {
    delete user.sessionToken;
  }
  if ((user != null ? user.updatedAt : void 0) != null) {
    delete user.updatedAt;
  }
  if ((user != null ? user.createdAt : void 0) != null) {
    delete user.createdAt;
  }
  // 返回的数据
  return {user, token};
};

resetPsd = async(req, res) => {
  var body, result;
  body = (await json(req));
  return result = (await services.Login.resetPsd(body));
};

export {
  login,
  register,
  resetPsd
};
