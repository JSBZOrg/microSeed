import jwt from 'jsonwebtoken'

generateToken = (objectId, sessionToken, username) =>
  jwt.sign
    objectId: objectId
    sessionToken: sessionToken
    dateTime: Date.now()
  , 'shhh'

verifyToken = (token) =>
  decoded = jwt.verify token, 'shhh'
  if (Date.now() - decoded.dateTime) / 1000 / 60 > 1440
    err:
      name: 'JsonWebTokenError'
      message: 'jwt is expired'
      code: 10001
  else
    objectId: decoded.objectId
    sessionToken: decoded.sessionToken

judgeIsVerify = (token) =>
  decoded = jwt.verify token, 'shhh'
  if decoded? and (Date.now() - decoded.dateTime) / 1000 / 60 < 1440
    return true
  else
    return false

refreshToken = (old_token) =>
  decoded = jwt.verify old_token, 'shhh'
  newToken = generateToken(
    decoded.objectId
    decoded.sessionToken
    decoded.username
  )
  newToken

export {
  verifyToken
  refreshToken
  judgeIsVerify
  generateToken  
}