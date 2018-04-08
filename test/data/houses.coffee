import landlord from './landlord'

export default [
    province: '湖北省'
    city: '武汉市'
    area: '武昌区'
    street: ''
    community: '安顺家园'
    building: '梅岭4栋'
    unit: '2单元'
    floor: '1401'
    area: '127.02'
    rentStartTime: '2016-11-01'
    rentEndTime: '2021-10-31'
    agent: '武汉聚联宝房地产代理有限公司'
    agentPhoneNo: ''
    agencyFees: '1800'
    rentMoney: '3600'
    earnestMoney: '3600'
    landlord: landlord[0]      # 房东
    otherLandlord: [           # 其他房东
      landlord[1]
      landlord[2]
    ]
    authorizer: landlord[1]    # 授权人
    payee: landlord[2]         # 结款人
  ,
    province: '湖北省'
    city: '武汉市'
    area: '武昌区'
    street: ''
    community: '安顺家园'
    building: '梅岭4栋'
    unit: '2单元'
    floor: '1401'
    area: '127.02'
    rentStartTime: '2016-11-01'
    rentEndTime: '2021-10-31'
    agent: '武汉聚联宝房地产代理有限公司'
    agentPhoneNo: ''
    agencyFees: '1800'
    rentMoney: '3600'
    earnestMoney: '3600'
    landlord: landlord[1]      # 房东
    otherLandlord: [           # 其他房东
      landlord[0]
      landlord[2]
    ]
    authorizer: landlord[1]    # 授权人
    payee: landlord[1]         # 结款人
]