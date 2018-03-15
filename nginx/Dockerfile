FROM nginx:latest
RUN mkdir /etc/nginx/ssl
COPY cert/proxy.key /etc/nginx/ssl/
COPY cert/proxy.crt /etc/nginx/ssl/
COPY nginx.conf /etc/nginx/conf.d/default.conf
