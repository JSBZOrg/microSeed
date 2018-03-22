import dd from 'ddeyes'
import 'shelljs/make'
import services from '../../../sources/services/leancloud'

target.all = =>
  dd 'hello, world!'

target.user = =>

  data = await services.Person.create {
    address: '测试'
  }
  dd data

  result = await services.Person.fetch {
    objectId: data.objectId
  }
  dd result

  updateData = await services.Person.update {
    objectId: data.objectId
    address: '修改'
  }
  dd updateData

  deleteData = await services.Person.delete {
    objectId: data.objectId
  }
  dd deleteData

  reloadData = await services.Person.reload()
  dd reloadData