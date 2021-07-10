import bodyParser from 'body-parser'
import express from 'express'
import Router from './routes/Main'
import { SERVER_PORT } from './constants'
import {allowCrossDomain} from './middlewares/security/CORS'
import {RequestHasUser} from "./middlewares/security/Authorize";

const server = express()

server.use(bodyParser.json())
server.use(allowCrossDomain)

server.use('/', Router)

server.use(RequestHasUser)

server.listen(SERVER_PORT, () => {
    console.log(`Server has started at port ${SERVER_PORT}`)
})

/*process.on("SIGTERM", () => {
    console.log('SIGTERM received, closing server now')
    prisma.$disconnect()
        .then(() => {console.log("Prisma DB Client disconnected")})
        .catch(() => {console.log("Prisma DB Client failed to disconnect. Continuing without regards...")})
        .finally(() => { liseneter.close(console.log) })
})*/
