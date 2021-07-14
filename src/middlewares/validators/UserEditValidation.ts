import { check } from "express-validator";
import {validatorFunc} from "./ValidatorBase";
import {Role} from "@prisma/client";

export const UserEditValidation = [
    [
        check("id", "Please provide a user id").not().isEmpty(),
        check("id", "Please provide a valid user id").isInt(),
        check("username", "Please provide a username").not().isEmpty(),
        check("password").optional(),
        check("role", "Please provide a role").not().isEmpty(),
        check("role", "Please provide a valid role").isIn(Object.values(Role))
    ],
    validatorFunc
]
