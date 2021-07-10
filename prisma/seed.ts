import { PrismaClient } from '@prisma/client'
import {genSaltSync, hashSync} from "bcrypt";
const prisma = new PrismaClient()

async function main() {
    const admin = await prisma.user.upsert({
        where: { username: 'admin' },
        update: {},
        create: {
            username: 'admin',
            password: hashSync('admin', genSaltSync(10)),
            role: 'ADMIN'
        },
    })
    console.log(`Default user created (admin: admin) with id: ${admin.id}`)
}

main()
    .catch(e => {
        console.error(e)
        process.exit(1)
    })
    .finally(async () => {
        await prisma.$disconnect()
    })