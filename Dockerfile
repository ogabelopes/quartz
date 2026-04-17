# syntax=docker/dockerfile:1

FROM node:24-slim AS builder
WORKDIR /quartz
COPY package.json package-lock.json* ./
RUN npm ci
COPY . .
RUN npx quartz build

FROM node:24-alpine3.23 AS runner
WORKDIR /app
RUN npm install -g serve
COPY --from=builder /quartz/public ./public
COPY serve.json ./serve.json
EXPOSE 3000
CMD ["serve", "public", "--listen", "3000", "--no-clipboard"]
