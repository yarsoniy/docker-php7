FROM ubuntu:16.04
MAINTAINER Yarsoniy "yarsoniy@gmail.com"
ENV REFRESHED_AT 2016-06-11

RUN apt-get update
RUN apt-get -y install \
	php7.0 \
	php7.0-mysql \
	php7.0-mcrypt \
	php7.0-dev \
	php-pear \
	apache2 \
	libapache2-mod-php7.0 \
	vim

#Xdebug
RUN yes | pecl install xdebug
RUN echo "zend_extension=$(find /usr/lib/php/ -name xdebug.so)" >> /etc/php/7.0/apache2/php.ini
RUN echo "zend_extension=$(find /usr/lib/php/ -name xdebug.so)" >> /etc/php/7.0/cli/php.ini

EXPOSE 80
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]