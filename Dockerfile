FROM node:lts-alpine3.14

# Create app directory
WORKDIR /app

COPY . .

# Install app dependencies
RUN yarn

RUN yarn run build

EXPOSE 3000
CMD [ "/bin/ash", "-c", "yarn run prisma migrate deploy && yarn run ts-node ./prisma/seed.ts && yarn run prod" ]
