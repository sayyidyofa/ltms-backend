import { check } from "express-validator";
import {validatorFunc} from "./ValidatorBase";

export const RegisterValidation = [
    [
        check("email", "Please provide an email").not().isEmpty().isEmail(),
        check("password", "Please provide a password").not().isEmpty()
    ],
    validatorFunc
]
