import { NextFunction, Request, Response } from "express";
import {validationResult} from "express-validator";
import {ValidationResponse} from "../../types/base/BackendResponse";

export const validatorFunc = (req: Request, res: Response, next: NextFunction): void => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        res.json(<ValidationResponse>{
            errors: errors.array().map(validationError => validationError.msg)
        })
        return;
    } else {
        next()
    }
}
