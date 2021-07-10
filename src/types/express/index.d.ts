import { AuthorizedUser } from "../security/AuthorizedUser";

declare global {
    namespace Express {
      export interface Request {
        currentUser?: AuthorizedUser
      }    
    }
  }