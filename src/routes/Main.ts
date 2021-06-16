import { Request, Response, Router } from 'express';
import { AuthenticationService } from '../services/AuthenticationService';

import {BasicResponse} from "../types/base/BackendResponse";

const router = Router()

// Auth
router.post('/auth', AuthenticationService)


router.get('/', (req: Request, res: Response): void => {
    res.json(<BasicResponse>{
        message: "ltms API root endpoint"
    })
})

export default router
