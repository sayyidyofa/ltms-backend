import { NextFunction, Request, Response } from "express";
import {NotBeforeError, TokenExpiredError, verify, VerifyErrors} from "jsonwebtoken";
import { JWT_KEY } from "../../constants";
import {AuthResponse} from "../../types/base/BackendResponse";
import {AuthorizedUser} from "../../types/security/AuthorizedUser";
import {panic} from "../../util/helpers";
import {Errors} from "../../constants";

export function AuthorizeToken(req: Request, res: Response, next: NextFunction): void {
    const authorizationHeader = req.headers['authorization']

    if (authorizationHeader === undefined) {
        res.status(400)
        res.json(<AuthResponse>{
            error: Errors.AUTH_TOKEN_INVALID
        })
        return
    }

    verify(authorizationHeader.substr(7), JWT_KEY, (err, decoded) => {
        if (err !== null) {
            res.status(401)
            switch (err.constructor) {
                case TokenExpiredError:
                    res.json(<AuthResponse>{
                        error: Errors.AUTH_TOKEN_EXPIRED
                    })
                    break
                case NotBeforeError:
                    res.json(<AuthResponse>{
                        error: Errors.AUTH_TOKEN_BEFORE
                    })
                    break
            }
            return
        } else {
            switch (typeof decoded) {
                case "undefined":
                    panic("Decoded token is undefined, proceeding to panic")
                    break
                case "object":
                    req.currentUser = <AuthorizedUser>decoded
                    next()
            }
        }
    })
}

export function RequestHasUser(req: Request, res: Response, next: NextFunction): void {
    switch (typeof req.currentUser) {
        case "undefined":
            res.json(<AuthResponse>{error: Errors.AUTH_REQUEST_CURRENT_USER_NONEXIST})
            break;
        case "object":
            next()
    }
}