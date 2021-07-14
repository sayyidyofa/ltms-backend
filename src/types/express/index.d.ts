import { AuthorizedUser } from "../security/AuthorizedUser";
import { PrismaClient } from '@prisma/client'

type ORM = PrismaClient;

declare global {
    namespace Express {
      export interface Request {
        currentUser?: AuthorizedUser
      }
    }
    namespace NodeJS {
        interface Global {
            orm: ORM
        }
    }
  }


declare const orm: ORM