# ltms-backend

## Development

1. Clone and run the command: `yarn` (Install yarn if yu dont have it)

2. Make new file: `.env` and fill it with values from `.env.example`

3. Run the database service `postgres` in file: `docker-compose.yml`

4. Run command: `yarn run prisma migrate reset`

5. Run command: `yarn run prisma generate`

6. To try running it, build (`yarn run build`) then run the transpiled code (`yarn run prod`)
