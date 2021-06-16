import process from 'process'

export const JWT_KEY = process.env.JWT_SECRET || 'developmentpurpose'
export const SERVER_PORT = process.env.PORT || 3000
export const TOKEN_VALIDITY_PERIOD = process.env.TOKEN_VALIDITY_PERIOD || 604800

export enum Errors {
    AUTH_TOKEN_INVALID      = "JWT Token Invalid",
    AUTH_DISCLAIM_RESOURCE  = "Resource is not owned by user",
    AUTH_TOKEN_EXPIRED      = "Token is expired",
    AUTH_TOKEN_BEFORE       = "Token time is invalid",
    AUTH_CRED_UNDEFINED     = "Email and password are required",
    AUTH_USER_NONEXIST      = "User not found"
}
