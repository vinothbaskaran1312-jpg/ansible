FROM httpd:2.4
#create public-html in docker node and create index.html
COPY ./public-html/ /usr/local/apache2/htdocs/
# $ docker build -t my-apache2 .
# $ docker run -dit --name my-running-app -p 8080:80 my-apache2

