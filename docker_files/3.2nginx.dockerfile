FROM nginx
#COPY hp.html /usr/share/nginx/html/index.html
ADD https://raw.githubusercontent.com/abdulshajahan/ansiblenov25/main/hp.html /usr/share/nginx/html/index.html
RUN chmod 644 /usr/share/nginx/html/index.html
EXPOSE 80
# Nginx runs in foreground by default in official image
# No need for CMD as it inherits from base image
# But we can explicitly state it for clarity:
CMD ["nginx", "-g", "daemon off;"]
