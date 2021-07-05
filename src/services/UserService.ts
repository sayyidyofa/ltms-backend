import {Request, Response} from "express";
import {db} from "./DatabaseService";
import { Prisma } from "@prisma/client";


export function addUser(req: Request, res: Response): void {
    db().user.create({
        data: req.body as unknown as Prisma.UserCreateInput
    }).then(res.json).catch(reason => {
        res.status(500)
        res.send(reason)
    })
}