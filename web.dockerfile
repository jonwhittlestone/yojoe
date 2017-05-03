# dev
#FROM nginx:1.10

#ADD vhost.conf /etc/nginx/conf.d/default.conf

# prod
FROM nginx:1.10-alpine

ADD vhost.conf /etc/nginx/conf.d/default.conf

COPY public /var/www/public
