import {Request, Response} from "express";
import { Prisma } from "@prisma/client";
import {AuthorizedUser} from "../types/security/AuthorizedUser";
import {RestResponse} from "../types/base/BackendResponse";
import {Errors} from "../constants";
import {genSalt, hash} from "bcrypt";

async function encryptPassword(passwordPlain: string): Promise<string> {
    const salt = await genSalt(10)
    return hash(passwordPlain, salt)
}

export async function addUser(req: Request, res: Response): Promise<void> {
    const userData = req.body as unknown as Prisma.UserCreateInput
    global.orm.user.create({
        data: {
            username: userData.username,
            password: await encryptPassword(userData.password),
            role: userData.role
        }
    }).then(user => {res.json(<RestResponse>{
        event: "created",
        data: {
            type: "id",
            content: user.id
        }
    })}).catch(reason => {
        console.dir(reason)
        res.status(500)
        res.json(<RestResponse>{
            error: reason
        })
    })
}

export async function editUser(req: Request, res: Response): Promise<void> {
    const userData = req.body as unknown as Prisma.UserUncheckedUpdateInput
    global.orm.user.update({
        where: {
            id: userData.id as number // IntFieldUpdateOperationsInput
        },
        data: userData.password !== undefined ? {
            username: userData.username,
            password: await encryptPassword(userData.password as string), // StringFieldUpdateOperationsInput
            role: userData.role
        } : {
            username: userData.username,
            role: userData.role
        }
    }).then(user => {
        res.json(<RestResponse>{
            event: "updated",
            data: {
                type: "id",
                content: user.id
            }
        })
    }).catch(reason => {
        switch (reason.constructor) {
            case Prisma.PrismaClientKnownRequestError:
                switch (reason.code) {
                    case "P2025":
                        res.status(404)
                        res.json(<RestResponse>{
                            event: "error",
                            error: `User with id ${userData.id} not found`
                        })
                        break
                    default:
                        res.status(500)
                        res.json(<RestResponse>{
                            event: "error",
                            error: reason
                        })
                        break
                }
                break
            default:
                res.status(500)
                res.json(<RestResponse>{
                    event: "error",
                    error: reason
                })
                break
        }
    })
}

export function me(req: Request, res: Response): void {
    global.orm.user.findUnique({
        where: {
            id: (<AuthorizedUser>req.currentUser).id
        },
        include: {
            relatedStudent: true,
            relatedTeacher: true
        }
    }).then(user => {
        if (user === null) {
            res.status(404)
            res.json(<RestResponse>{
                event: "error",
                error: Errors.AUTH_USER_NONEXIST
            })
            return
        }
        if (user.relatedTeacher !== null) {
            res.json(<RestResponse>{
                event: "retrieved",
                data: {
                    type: "singular",
                    content: user.relatedTeacher
                }
            })
        }
        else if (user.relatedStudent !== null) {
            res.json(<RestResponse>{
                event: "retrieved",
                data: {
                    type: "singular",
                    content: user.relatedStudent
                }
            })
        } else res.json(<RestResponse>{
            event: "retrieved",
            data: {
                type: "singular",
                content: user
            }
        })
    })
}