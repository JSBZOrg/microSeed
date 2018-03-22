import dd from 'ddeyes'
import 'shelljs/make'
import services from '../../../sources/services/local'

target.all = =>
  dd 'hello,world!'
  dd Object.keys services.user

target.user = =>

  data = await services.user.create {
    address: '测试'
  }
  dd data

  result = await services.user.fetch {
    objectId: data.objectId
  }
  dd result

  updateData = await services.user.update {
    objectId: data.objectId
    address: '修改'
  }
  dd updateData

  deleteData = await services.user.delete {
    objectId: data.objectId
  }
  dd deleteData

  reloadData = await services.user.reload()
  dd reloadData