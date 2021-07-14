import { User, Teacher, TahfizhGroup, Student, Session, Alquran, Percepatan } from '@prisma/client'

type Resource = User | Teacher | TahfizhGroup | Student | Session | Percepatan | Alquran

export type BasicResponse = {
    message: string
}

export type AuthResponse = {
    token?: string,
    error?: string
}

export type ValidationResponse = {
    errors: string[]
}

type ResourceID = number;

export type RestResponse = {
    event: "created" | "retrieved" | "updated" | "deleted" | "error"
    data?: {
        type: "singular" | "multiple" | "id",
        content: Resource | Resource[] | ResourceID
    }
    error?: string | Record<string, unknown>
}
