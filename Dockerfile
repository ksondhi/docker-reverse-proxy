#Download base image ubuntu 16.04
FROM ubuntu:16.04
# Update Ubuntu Software repository
RUN echo "Updating Ubuntu Software repository..."
RUN apt-get update -y
RUN echo "Installing VIM..."
RUN apt-get install vim -y
# Install Apache server
RUN echo "Installing Apache server..."
RUN apt-get install apache2 -y
RUN apache2ctl configtest
RUN apache2ctl start

# Install mod-proxy for Apache Reverse Proxying

RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_balancer
RUN a2enmod lbmethod_byrequests
RUN apache2ctl restart

EXPOSE 80 443