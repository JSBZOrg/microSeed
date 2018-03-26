import dd from 'ddeyes'
import 'shelljs/make'
import services from '../../../sources/services/local'

target.all = =>
  dd 'hello,world!'
  dd Object.keys services.user

target.user = =>

  user = await services.Login.login {
    username: '何文涛'
    password: '123456'
  }
  dd user
  
  data = await services.user.create {
    token: user.token
    address: '测试'
  }
  dd data

  result = await services.user.fetch {
    token: user.token    
    objectId: data.objectId
  }
  dd result

  updateData = await services.user.update {
    token: user.token    
    objectId: data.objectId
    address: '修改'
  }
  dd updateData

  deleteData = await services.user.delete {
    token: user.token    
    objectId: data.objectId
  }
  dd deleteData

  reloadData = await services.user.reload {
    token: user.token    
  }
  dd reloadData