import LC_Key from '../../lcKey'

classes = [
  'Person'
  'Landlords'
  'Tenants'
  'Todos'
  'Notices'
  'Houses'
  'Rooms'
  'Beds'
  'Rents'
  'Orders'
]

urlConf =
  withSSL: true
  host: "#{LC_Key.id[0..7].toLowerCase()}.api.lncld.net"
  prefix: ({
    business
  }) =>
    base = '1.1'
    (
      Object.keys business
    ).reduce (r, c) =>
      {
        r...
        "#{c}":
          if c in classes
          then "#{base}/classes"
          else base
      }
    , {}
  headers:
    "X-LC-Id": LC_Key.id
    "X-LC-Key": LC_Key.key

export {
  classes
  urlConf
} 
