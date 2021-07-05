import BCrypt from 'bcrypt';
import { Request, Response } from "express";
import {sign, SignOptions} from 'jsonwebtoken';
import {JWT_KEY, TOKEN_VALIDITY_PERIOD} from "../constants";
import {db} from "./DatabaseService";
import {isAuthable} from "../util/helpers";
import {AuthResponse, BasicResponse} from "../types/base/BackendResponse";
import {Errors} from "../constants";
import { Authable } from '../types/security/Authable';

/**
 * Authenticate user function. This function will send response that
 * contain a JWT token.
 *
 * @param req Request
 * @param res Response
 */
export function AuthenticationService(req: Request, res: Response): void {
    if (isAuthable(req.body)) 
    db().user.findUnique({where: {code: (<Authable>req.body).code}})
        .then(user => {
            if (user === null) {
                res.status(404)
                res.json(<AuthResponse>{
                    error: Errors.AUTH_USER_NONEXIST
                })
            }
            else {
                BCrypt.compare((<Authable>req.body).password, user.password)
                    .then(isValid => {
                        if (isValid) res.json(<AuthResponse>{
                            token: sign({ user: { id: user.id } }, JWT_KEY, <SignOptions> {
                                expiresIn: TOKEN_VALIDITY_PERIOD
                            })
                        })
                    }).catch(reason => {
                        console.error(reason)
                        res.status(500)
                        res.json(<BasicResponse> {
                            message: "Internal server error at comparing auth"
                        })
                    })
            }
        }).catch(console.log)
    else {
        res.status(400)
        res.json(<AuthResponse>{
            error: Errors.AUTH_CRED_UNDEFINED
        })
    }
}
