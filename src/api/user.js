// Generated by CoffeeScript 2.2.4
var createUser, deleteUser, fetchUser, findUserWithIDCard, reloadUser, updateUser;

import {
  json
} from 'micro';

import services from '../services/leancloud';

import {
  judgeIsVerify
} from '../utils/helper';

createUser = async(req, res) => {
  var body;
  body = (await json(req));
  if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
    delete body.token;
    return (await services.Person.create(body));
  }
};

fetchUser = async(req, res) => {
  var body;
  body = (await json(req));
  if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
    return (await services.Person.fetch({
      objectId: body.objectId
    }));
  }
};

updateUser = async(req, res) => {
  var body;
  body = (await json(req));
  if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
    delete body.token;
    return (await services.Person.update(body));
  }
};

deleteUser = async(req, res) => {
  var body;
  body = (await json(req));
  if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
    return (await services.Person.delete({
      objectId: body.objectId
    }));
  }
};

reloadUser = async(req, res) => {
  var body;
  body = (await json(req));
  if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
    return (await services.Person.reload());
  }
};

findUserWithIDCard = async(req, res) => {
  var body;
  body = (await json(req));
  if (((body != null ? body.token : void 0) != null) && judgeIsVerify(body.token) === true) {
    return (await services.Special.findUserWithIDCard(body));
  }
};

export {
  createUser,
  fetchUser,
  updateUser,
  deleteUser,
  reloadUser,
  findUserWithIDCard
};
