FROM node:16.14.0-alpine as build-step
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm ci

COPY ../ .
RUN npm run build --prod

FROM nginx:alpine
COPY --from=build-step /app/dist/tbd-frontend /usr/share/nginx/html
