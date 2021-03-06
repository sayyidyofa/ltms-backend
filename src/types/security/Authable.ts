import { User } from ".prisma/client";

export type Authable = Pick<User, "username" | "password" | "role">