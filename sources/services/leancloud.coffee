import getService from 'cfx.service'
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
  allClasses...
}

services = getService {
  urlConf
  business
}

export default services