import getService from 'cfx.service'
import urlencode from 'urlencode'
import { verifyToken } from '../utils/helper'
import { classes, urlConf } from '../../sources/config/config.leancloud'

allClasses = classes.reduce (r, c) =>
  {
    r...
    "#{c}"
  }
, {}

business = {
  Login:

    register:
      uri: ({
        baseUrl
      }) => "#{baseUrl}/users"
      method: 'POST'
    
    login: ({
      request
      baseUrl
      headers
    }) =>
      ({
        username
        password
        otherParams...
      }) =>
        request "#{baseUrl}/login"
        , {
          method: 'POST'
          headers
          data: {
            username
            password
            otherParams...
          }
        }
    
    resetPsd: ({
      request
      baseUrl
      headers
    }) =>
      (data) =>
        objectId = verifyToken(data.token).objectId
        url = "#{baseUrl}/users/#{objectId}/updatePassword"
        newHeaders = {
          headers...
          'X-LC-Session': verifyToken(data.token).sessionToken
        }
        request url
        , {
          method: 'put'
          headers: newHeaders
          data
        }

  Special:

    findLandlordWithIDCard: ({
      request
      baseUrl
      headers
    }) =>
      (data) =>
        qsEncode = urlencode JSON.stringify IDCard: "#{data.IDCard}"
        request "#{baseUrl}/classes/Landlords?where=#{qsEncode}"
        , {
          method: 'GET'
          headers
          data
        }
    
    findUserWithIDCard: ({
      request
      baseUrl
      headers
    }) =>
      (data) =>
        qsEncode = urlencode JSON.stringify IDCard: "#{data.IDCard}"
        request "#{baseUrl}/classes/Person?where=#{qsEncode}"
        , {
          method: 'GET'
          headers
          data
        }

  allClasses...
}

services = getService {
  urlConf
  business
}

export default services