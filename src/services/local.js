// Generated by CoffeeScript 2.2.4
var business, classes, services,
  _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; },
  objectWithoutKeys = function(o, ks) { var res = {}; for (var k in o) ([].indexOf.call(ks, k) < 0 && {}.hasOwnProperty.call(o, k)) && (res[k] = o[k]); return res; };

import getService from 'cfx.service';

import urlConf from '../../localConf';

classes = ['user', 'landlord', 'house', 'room', 'bed', 'tenant'].reduce((r, c) => {
  var ref;
  return _extends({}, r, {[ref = `${c}`]: ref});
}, {});

business = _extends({
  Login: {
    register: {
      uri: ({baseUrl}) => {
        return `${baseUrl}/signup`;
      },
      method: 'POST'
    },
    login: ({request, baseUrl}) => {
      return (arg) => {
        var otherParams, password, username;
        ({username, password} = arg);
        otherParams = objectWithoutKeys(arg, ['username', 'password']);
        return request(`${baseUrl}/login`, {
          method: 'POST',
          data: _extends({username, password}, otherParams)
        });
      };
    },
    resetPsd: ({request, baseUrl}) => {
      return (data) => {
        return request(`${baseUrl}/resetPsd`, {
          method: 'put',
          data
        });
      };
    }
  },
  Special: {
    findLandlordWithIDCard: ({request, baseUrl, headers}) => {
      return (data) => {
        return request(`${baseUrl}/landlord/link/${data.IDCard}`, {
          method: 'GET',
          headers,
          data
        });
      };
    },
    findUserWithIDCard: ({request, baseUrl, headers}) => {
      return (data) => {
        return request(`${baseUrl}/user/link/${data.IDCard}`, {
          method: 'GET',
          headers,
          data
        });
      };
    },
    findHouseWithLandlord: ({request, baseUrl, headers}) => {
      return (data) => {
        return request(`${baseUrl}/house/link/${data.landlordId}`, {
          method: 'GET',
          headers,
          data
        });
      };
    },
    findRoomWithHouse: ({request, baseUrl, headers}) => {
      return (data) => {
        return request(`${baseUrl}/room/link/${data.houseId}`, {
          method: 'GET',
          headers,
          data
        });
      };
    },
    findBedWithRoom: ({request, baseUrl, headers}) => {
      return (data) => {
        return request(`${baseUrl}/bed/link/${data.roomId}`, {
          method: 'GET',
          headers,
          data
        });
      };
    }
  }
}, classes);

services = getService({urlConf, business});

export default services;
