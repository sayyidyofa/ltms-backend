import { PrismaClient } from '@prisma/client'

export function db(): PrismaClient {
    return new PrismaClient()
}
