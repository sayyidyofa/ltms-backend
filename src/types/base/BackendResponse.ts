import { User, Teacher, TahfizhGroup, Student, Session, Alquran } from '@prisma/client'

type Resource = User | Teacher | TahfizhGroup | Student | Session | Alquran

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
