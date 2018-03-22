import dd from 'ddeyes'
import 'shelljs/make'
import services from '../../../sources/services/leancloud'

target.all = =>
  dd 'Hello World!!!'
  dd Object.keys services.Person

target.login = =>

  result = await services.Login.register {
    username: '张三'
    password: '123456'
  }
  dd result

  data = await services.Login.login {
    username: '张三'
    password: '123456'
  }
  dd data

  result = await services.Login.resetPsd {
    token: data.token  # 需要token
    old_password: '123456'
    new_password: '123456'
  }
  dd result
