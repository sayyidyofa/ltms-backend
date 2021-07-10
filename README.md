# ltms-backend

## Development

0. Make sure you have docker and docker-compose.

1. Clone and run the command: `yarn` (Install yarn if you dont have it)

2. Make new file: `.env` and fill it with values from `.env.example`

3. Run the database service `postgres` in file: `docker-compose.yml`

4. Run command: `yarn run prisma migrate deploy`

5. Run command: `yarn run ts-node prisma/seed.ts`

6. To try running it, build (`yarn run build`) then run the transpiled code (`yarn run prod`)
