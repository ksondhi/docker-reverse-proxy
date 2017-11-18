#Download base image ubuntu 16.04
FROM ubuntu:16.04
# Update Ubuntu Software repository
RUN echo "Updating Ubuntu Software repository..."
RUN apt-get update -y
RUN echo "Installing VIM..."
RUN apt-get install vim -y
RUN echo "Installing curl..."
RUN apt-get install curl -y
# Install Apache server
RUN echo "Installing Apache server..."
RUN apt-get install apache2 -y
RUN apache2ctl configtest
RUN apache2ctl start

# Install mod-proxy for Apache Reverse Proxying

RUN a2enmod ssl
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_html
RUN a2enmod xml2enc
RUN a2enmod rewrite
RUN a2enmod proxy_balancer
RUN a2enmod lbmethod_byrequests

COPY conf/000-default.conf /etc/apache2/sites-available/
COPY conf/ssl/apache-selfsigned.key /etc/ssl/private/
COPY conf/ssl/apache-selfsigned.crt /etc/ssl/certs/
COPY conf/ssl/dhparam.pem /etc/ssl/certs/
COPY conf/ssl/ssl-params.conf /etc/apache2/conf-available/

RUN apache2ctl restart

# To generate the SSL Self-Signed Certificate 
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
# openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
# create  /etc/apache2/conf-available/ssl-params.conf
# To find out ServerName openssl x509 -in server.crt -noout -subject

EXPOSE 80 443

