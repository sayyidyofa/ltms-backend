import { Authable } from '../types/security/Authable';

export function panic(message: string): never {
    throw new Error(message);
}

export const isAuthable =
    (input: Record<string, unknown>)
        : input is Authable =>
        typeof input.email === "string" && typeof input.password === "string";
