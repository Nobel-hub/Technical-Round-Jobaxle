# This is a multistage Dockerfile
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build


FROM gcr.io/distroless/nodejs20-debian12

WORKDIR /app

COPY --from=builder /app /app

CMD ["index.js"]
