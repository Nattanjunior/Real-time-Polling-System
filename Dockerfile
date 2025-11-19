FROM node:24-alpine AS builder

WORKDIR /app

COPY package*.json ./
COPY prisma/ ./prisma/

RUN npm ci && npm cache clean --force

RUN npx prisma generate

FROM node:20-alpine AS production

WORKDIR /app

COPY package*.json ./
COPY prisma/ ./prisma/

RUN npm ci --only=production && npm cache clean --force

COPY --from=builder /app/node_modules/.prisma ./node_modules/.prisma

COPY dist/ ./dist/

RUN addgroup -g 1001 -S nodejs
RUN adduser -S nestjs -u 1001
USER nestjs

EXPOSE 3000

CMD ["sh", "-c", "npx prisma migrate deploy && node dist/main.js"]