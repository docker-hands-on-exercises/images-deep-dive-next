// Hello 02
const express = require('express')
const app = express()

app.use(express.static('.'))

const http_port = 8080
app.listen(http_port, () => {
  console.log(`🌍 listening on ${http_port}`)
})