require('dotenv').config()
if process?.env?.ID? and process?.env?.KEY?
  lcKey = 
    id: process.env.ID
    key: process.env.KEY
else
  lcKey = 
    id: 'GIVjfb4jm56HdbjJAj5B10FX-gzGzoHsz'
    key: 'gBqONgCzJJB5KkGOcVF56Rxe'

export default lcKey
