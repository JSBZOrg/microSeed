import dd from 'ddeyes'
import 'shelljs/make'
import services from '../../../sources/services/leancloud'

target.all = =>
  dd 'Hello World!!!'
  dd Object.keys services.Person

target.register = =>

  result = await services.Login.register {
    username: '张三'
    password: '123456'
  }
  dd result

target.login = =>

  data = await services.Login.login {
    username: '何文涛'
    password: '123456'
  }
  dd data

target.resetPsd = =>

  result = await services.Login.resetPsd {
    token: '' # 需要token
    old_password: '123456'
    new_password: '123456'
  }
  dd result
