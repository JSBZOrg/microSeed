require('dotenv').config()
if process?.env?.WITHSSL? and 
   process?.env?.HOST? and 
   process?.env?.PORT?
  urlConf =
    withSSL: process.env.WITHSSL 
    host: process.env.HOST
    port: process.env.PORT
else
  urlConf =
    withSSL: false
    host: 'localhost'
    port: '3000'

export default urlConf