# containers/nginx/Dockerfile
FROM nginx:1.12.0
RUN rm -f /etc/nginx/conf.d/*

ADD nginx.conf /etc/nginx/conf.d/Zeroken.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
