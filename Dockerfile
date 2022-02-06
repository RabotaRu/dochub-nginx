# syntax = docker/dockerfile:1.3
FROM node:12-alpine AS deps
WORKDIR /var/www
COPY package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm npm install


FROM node:12-alpine AS builder
WORKDIR /var/www
COPY --from=deps /var/www .
COPY . .
ENV NODE_ENV=production
# RUN --mount=type=cache,target=./node_modules/.cache npm run build
RUN npm run build
CMD ["npm", "run", "serve"]
EXPOSE 8080


FROM nginxinc/nginx-unprivileged:1.21-alpine as nginx
COPY --chown=101 --from=builder /var/www/dist /usr/share/nginx/html
COPY 40-sed.sh /docker-entrypoint.d/40-sed.sh
