FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY . .

LABEL org.opencontainers.image.source="https://github.com/eslammohamedhelmy-git/hello-world-app"

ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["npm", "start"]