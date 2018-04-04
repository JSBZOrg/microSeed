require('dotenv').config()
if process?.env?.WITHSSL? and 
   process?.env?.HOST? and 
   process?.env?.PORT?
  urlConf =
    withSSL: process.env.WITHSSL    # 可不写默认就为 false
    host: process.env.HOST          # 可不写默认就为 localhost
    port: process.env.PORT
else
  urlConf =
    withSSL: false
    host: 'localhost'
    port: '3000'

export default urlConf