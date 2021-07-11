FROM node:14 AS builder

# Create app directory
WORKDIR /app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package.json ./
COPY yarn.lock ./
COPY prisma ./prisma/
COPY .env ./

# Install app dependencies
RUN yarn
# Required if not done in postinstall
RUN yarn run prisma migrate deploy
RUN yarn run ts-node ./prisma/seed.ts

COPY . .

RUN yarn run build

FROM node:14

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/.env ./

EXPOSE 3000
CMD [ "yarn", "run", "start:prod" ]
