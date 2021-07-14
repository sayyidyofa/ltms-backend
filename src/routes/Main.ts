import { Request, Response, Router } from 'express';
import { AuthenticationService } from '../services/AuthenticationService';

import {BasicResponse} from "../types/base/BackendResponse";
import {addUser, editUser, me} from "../services/UserService";
import {UserRegisterValidation} from "../middlewares/validators/UserRegisterValidation";
import {AuthorizeToken} from "../middlewares/security/Authorize";
import {UserEditValidation} from "../middlewares/validators/UserEditValidation";

const router = Router()

// Auth
router.post('/auth', AuthenticationService)

// User
router.post('/users', AuthorizeToken, ...UserRegisterValidation, addUser)
router.put('/users', AuthorizeToken, ...UserEditValidation, editUser)

router.get('/me', AuthorizeToken, me)


router.get('/', (req: Request, res: Response): void => {
    res.json(<BasicResponse>{
        message: "ltms API root endpoint"
    })
})

export default router
