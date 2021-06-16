import { User, Post } from '@prisma/client'

type Resource = User | Post

export type BasicResponse = {
    message: string
}

export type AuthResponse = {
    token?: string,
    error?: string
}

export type ValidationResponse = {
    errors: [string]
}

export type RestResponse = {
    data?: [Resource],
    error?: string
}
