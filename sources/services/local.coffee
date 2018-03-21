import getService from 'cfx.service'
import urlConf from '../../localConf'

classes = [
  'user'
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
      }) => "#{baseUrl}/register"
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
  classes...
}

services = getService {
  urlConf
  business
}

export default services