FROM nginxinc/nginx-unprivileged
USER nginx
COPY ./html /var/www/html
COPY nginx_data/nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080