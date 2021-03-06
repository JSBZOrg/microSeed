import landlord from './landlord'
import room01 from '../data/house/room01/room'
import room02 from '../data/house/room02/room'
import room03 from '../data/house/room03/room'
import room04 from '../data/house/room04/room'
import room05 from '../data/house/room05/room'
import room06 from '../data/house/room06/room'
import beds01 from '../data/house/room01/beds'
import beds02 from '../data/house/room02/beds'
import beds03 from '../data/house/room03/beds'
import beds04 from '../data/house/room04/beds'
import beds05 from '../data/house/room05/beds'
import beds06 from '../data/house/room06/beds'

export default [
    province: '湖北省'
    city: '武汉市'
    area: '武昌区'
    street: ''
    community: '安顺家园'
    building: '梅岭4栋'
    unit: '2单元'
    floor: '1401'
    acreage: 127.02
    rentType: '分租'
    rentStartTime: '2016-11-01'
    rentEndTime: '2021-10-31'
    agent: '武汉聚联宝房地产代理有限公司'
    agentPhoneNo: ''
    agencyFees: 1800
    rentMoney: 3600
    earnestMoney: 3600
    landlord: landlord[0]      # 房东
    otherLandlord: [           # 其他房东
      landlord[1]
    ]
    authorizer: landlord[0]    # 授权人
    payee: landlord[0]         # 结款人
    room: [
      room01
    ]
    beds: beds01
  ,
    province: '湖北省'
    city: '武汉市'
    area: '武昌区'
    street: ''
    community: '安顺家园'
    building: '菊坊2号'
    unit: '1单元'
    floor: '404'
    acreage: 140.2
    rentType: '分租'    
    rentStartTime: '2017-04-01'
    rentEndTime: '2022-03-31'
    agent: ''
    agentPhoneNo: ''
    agencyFees: 2500
    rentMoney: 5000
    earnestMoney: 5000
    landlord: landlord[7]      # 房东
    otherLandlord: []          # 其他房东
    authorizer: landlord[7]    # 授权人
    payee: landlord[7]         # 结款人
    room: [
      room02
    ]
    beds: beds02
  ,
    province: '湖北省'
    city: '武汉市'
    area: '武昌区'
    street: ''
    community: '安顺星苑'
    building: '9栋'
    unit: '1单元'
    floor: '702'
    acreage: 138.71
    rentType: '分租'    
    rentStartTime: '2016-11-10'
    rentEndTime: '2021-11-09'
    agent: '武汉吉家房地产经纪服务有限公司'
    agentPhoneNo: '027-87121288'
    agencyFees: 2500
    rentMoney: 5000
    earnestMoney: 10000
    landlord: landlord[2]      # 房东
    otherLandlord: []          # 其他房东
    authorizer: landlord[2]    # 授权人
    payee: landlord[2]         # 结款人
    room: [
      room03
    ]
    beds: beds03
  ,
    province: '湖北省'
    city: '武汉市'
    area: '武昌区'
    street: ''
    community: '安顺星苑'
    building: '10栋'
    unit: '1单元'
    floor: '1202'
    acreage: 138.28
    rentType: '分租'    
    rentStartTime: '2017-01-15'
    rentEndTime: '2022-01-14'
    agent: '武汉丰联地产经纪有限公司'
    agentPhoneNo: '027-87881169'
    agencyFees: 2500
    rentMoney: 5000
    earnestMoney: 5000
    landlord: landlord[3]      # 房东
    otherLandlord: []          # 其他房东
    authorizer: landlord[3]    # 授权人
    payee: landlord[3]         # 结款人
    room: [
      room04
    ]
    beds: beds04
  ,
    province: '湖北省'
    city: '武汉市'
    area: '武昌区'
    street: ''
    community: '安顺花园'
    building: 'D栋'
    unit: '1单元'
    floor: '503'
    acreage: 140
    rentType: '分租'    
    rentStartTime: '2017-03-01'
    rentEndTime: '2022-02-28'
    agent: '武汉熹宸房地产经纪有限公司'
    agentPhoneNo: '027-87333363'
    agencyFees: 1800
    rentMoney: 4600
    earnestMoney: 9200
    landlord: landlord[4]      # 房东
    otherLandlord: [           # 其他房东
      landlord[5]
    ]          
    authorizer: landlord[4]    # 授权人
    payee: landlord[4]         # 结款人
    room: [
      room05
    ]
    beds: beds05
  ,
    province: '湖北省'
    city: '武汉市'
    area: '武昌区'
    street: ''
    community: '安顺花园'
    building: 'D栋'
    unit: '1单元'
    floor: '103'
    acreage: 148.53
    rentType: '分租'    
    rentStartTime: '2017-03-15'
    rentEndTime: '2022-03-15'
    agent: '武汉丰联地产经纪有限公司'
    agentPhoneNo: '027-87881169'
    agencyFees: 2400
    rentMoney: 6000
    earnestMoney: 6000
    landlord: landlord[6]      # 房东
    otherLandlord: []          # 其他房东
    authorizer: landlord[6]    # 授权人
    payee: landlord[6]         # 结款人
    room: [
      room06
    ]
    beds: beds06
]