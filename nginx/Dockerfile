FROM node:18-buster as builder

RUN mkdir -p /app
WORKDIR /app
COPY ./frontend/package.json package.json
RUN yarn install

COPY ./frontend /app

RUN yarn next build

FROM nginx:1.21.0-alpine as production
ENV NODE_ENV production

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/.next /usr/share/nginx/html/_next
COPY --from=builder /app/public /usr/share/nginx/html

COPY ./nginx/local.conf /etc/nginx/conf.d/default.conf

RUN chown -R nginx:nginx /usr/share/nginx/html

EXPOSE 80 443
# start nginx
CMD ["nginx", "-g", "daemon off;"]