FROM node:latest AS builder
WORKDIR /usr/src/app
COPY package*.json .
RUN npm ci --only=production
COPY . .
RUN npm run build

FROM node:alpine
WORKDIR /urs/src/app
COPY --from=builder /usr/src/app/build .

EXPOSE 8080
CMD npx -y serve -s . -p 8080