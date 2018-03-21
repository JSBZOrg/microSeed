import dd from 'ddeyes'
import 'shelljs/make'
import services from '../../../sources/services/local'

target.all = =>
  dd 'hello, world!'

target.login = =>

  registerData = await services.Login.register {
    username: '张三'
    password: '123456'
  }
  dd registerData

  loginData = await services.Login.login {
    username: '张三'
    password: '123456'
  }
  dd loginData

  resetPwdData = await services.Login.resetPsd {
    token: loginData.token
    old_password: '123456'
    new_password: '123456'
  }
  dd resetPwdData

