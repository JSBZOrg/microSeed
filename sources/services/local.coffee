import getService from 'cfx.service'
import urlConf from '../../localConf'

classes = [
  'user'
  'landlord'
  'house'
  'room'
  'bed'
].reduce (r, c) =>
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
      }) => "#{baseUrl}/signup"
      method: 'POST'

    login: ({
      request
      baseUrl
    }) =>
      ({
        username
        password
        otherParams...
      }) =>
        request "#{baseUrl}/login"
        , {
          method: 'POST'
          data: {
            username
            password
            otherParams...
          }
        }

    resetPsd: ({
      request
      baseUrl
    }) =>
      (data) =>
        request "#{baseUrl}/resetPsd"
        , {
          method: 'put'
          data
        }

  Special:

    findLandlordWithIDCard: ({
      request
      baseUrl
      headers
    }) =>
      (data) =>
        request "#{baseUrl}/landlord/link/#{data.IDCard}"
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
        request "#{baseUrl}/user/link/#{data.IDCard}"
        , {
          method: 'GET'
          headers
          data
        }

  classes...
}

services = getService {
  urlConf
  business
}

export default services