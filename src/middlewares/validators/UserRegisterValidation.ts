import { check } from "express-validator";
import {validatorFunc} from "./ValidatorBase";
import {Role} from "@prisma/client";

export const UserRegisterValidation = [
    [
        check("username", "Please provide a username").not().isEmpty(),
        check("password", "Please provide a password").not().isEmpty(),
        check("role", "Please provide a role").not().isEmpty(),
        check("role", "Please provide a valid role").isIn(Object.values(Role))
    ],
    validatorFunc
]
