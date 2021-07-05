import { User } from ".prisma/client";

export type Authable = Pick<User, "code" | "password" | "role">