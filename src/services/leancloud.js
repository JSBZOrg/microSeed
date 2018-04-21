// Generated by CoffeeScript 2.2.4
var allClasses, business, services,
  _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; },
  objectWithoutKeys = function(o, ks) { var res = {}; for (var k in o) ([].indexOf.call(ks, k) < 0 && {}.hasOwnProperty.call(o, k)) && (res[k] = o[k]); return res; };

import getService from 'cfx.service';

import urlencode from 'urlencode';

import {
  verifyToken
} from '../utils/helper';

import {
  classes,
  urlConf
} from '../../sources/config/config.leancloud';

allClasses = classes.reduce((r, c) => {
  var ref;
  return _extends({}, r, {[ref = `${c}`]: ref});
}, {});

business = _extends({
  Login: {
    register: {
      uri: ({baseUrl}) => {
        return `${baseUrl}/users`;
      },
      method: 'POST'
    },
    login: ({request, baseUrl, headers}) => {
      return (arg) => {
        var otherParams, password, username;
        ({username, password} = arg);
        otherParams = objectWithoutKeys(arg, ['username', 'password']);
        return request(`${baseUrl}/login`, {
          method: 'POST',
          headers,
          data: _extends({username, password}, otherParams)
        });
      };
    },
    resetPsd: ({request, baseUrl, headers}) => {
      return (data) => {
        var newHeaders, objectId, url;
        objectId = verifyToken(data.token).objectId;
        url = `${baseUrl}/users/${objectId}/updatePassword`;
        newHeaders = _extends({}, headers, {
          'X-LC-Session': verifyToken(data.token).sessionToken
        });
        return request(url, {
          method: 'put',
          headers: newHeaders,
          data
        });
      };
    }
  },
  Special: {
    findLandlordWithIDCard: ({request, baseUrl, headers}) => {
      return (data) => {
        var qsEncode;
        qsEncode = urlencode(JSON.stringify({
          IDCard: `${data.IDCard}`
        }));
        return request(`${baseUrl}/classes/Landlords?where=${qsEncode}`, {
          method: 'GET',
          headers,
          data
        });
      };
    },
    findUserWithIDCard: ({request, baseUrl, headers}) => {
      return (data) => {
        var qsEncode;
        qsEncode = urlencode(JSON.stringify({
          IDCard: `${data.IDCard}`
        }));
        return request(`${baseUrl}/classes/Person?where=${qsEncode}`, {
          method: 'GET',
          headers,
          data
        });
      };
    },
    findHouseWithLandlord: ({request, baseUrl, headers}) => {
      return (data) => {
        var qsEncode;
        qsEncode = urlencode(JSON.stringify({
          landlordId: `${data.landlordId}`
        }));
        return request(`${baseUrl}/classes/Houses?where=${qsEncode}`, {
          method: 'GET',
          headers,
          data
        });
      };
    },
    findRoomWithHouse: ({request, baseUrl, headers}) => {
      return (data) => {
        var qsEncode;
        qsEncode = urlencode(JSON.stringify({
          houseId: `${data.houseId}`
        }));
        return request(`${baseUrl}/classes/Rooms?where=${qsEncode}`, {
          method: 'GET',
          headers,
          data
        });
      };
    },
    findBedWithRoom: ({request, baseUrl, headers}) => {
      return (data) => {
        var qsEncode;
        qsEncode = urlencode(JSON.stringify({
          roomId: `${data.roomId}`
        }));
        return request(`${baseUrl}/classes/Beds?where=${qsEncode}`, {
          method: 'GET',
          headers,
          data
        });
      };
    }
  }
}, allClasses);

services = getService({urlConf, business});

export default services;
