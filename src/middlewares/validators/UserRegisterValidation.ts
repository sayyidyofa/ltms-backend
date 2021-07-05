import { check } from "express-validator";
import {validatorFunc} from "./ValidatorBase";

export const userRegisterValidation = [
    [
        check("email", "Please provide an email").not().isEmpty(),
        check("password", "Please provide a password").not().isEmpty()
    ],
    validatorFunc
]
