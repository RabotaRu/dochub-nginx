FROM nginxinc/nginx-unprivileged:1.21-alpine as nginx
COPY 40-sed.sh /docker-entrypoint.d/40-sed.sh
COPY nginx.conf /etc/nginx/conf.d/default.conf
