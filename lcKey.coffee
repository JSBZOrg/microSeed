require('dotenv').config()
if process?.env?
  lcKey = 
    id: process.env.ID
    key: process.env.KEY
else
  lcKey = 
    id: 'AtqISomogAEVLsjm6scgVE7K-gzGzoHsz'
    key: 'rkhxIbanALHnF6jhCsIHj8u6'

export default lcKey
  