type jwtLibPayloadBase = {
    iat: number,
    exp: number
}

export type AuthorizedUser = {
    id: number,
    role: string
} & jwtLibPayloadBase
