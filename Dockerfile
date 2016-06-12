FROM ubuntu:16.04
MAINTAINER Yarsoniy "yarsoniy@gmail.com"
ENV REFRESHED_AT 2016-06-11

RUN apt-get update
RUN apt-get -y install \
	php7.0 \
	php7.0-mysql \
	php7.0-mcrypt \
	php7.0-dev \
	apache2 \
	libapache2-mod-php7.0 \
	php-pear

RUN yes | pecl install xdebug

# Xdebug config for apache
RUN echo "zend_extension=$(find /usr/lib/php/ -name xdebug.so)" >> /etc/php/7.0/apache2/php.ini \
	&& echo "xdebug.remote_enable=on" >> /etc/php/7.0/apache2/php.ini \
	&& echo "xdebug.remote_connect_back=on" >> /etc/php/7.0/apache2/php.ini

# Xdebug config for php-cli
RUN echo "zend_extension=$(find /usr/lib/php/ -name xdebug.so)" >> /etc/php/7.0/cli/php.ini \
	&& echo "xdebug.remote_enable=on" >> /etc/php/7.0/cli/php.ini \
	&& echo "xdebug.remote_connect_back=on" >> /etc/php/7.0/cli/php.ini

ENV XDEBUG_CONFIG "idekey=PHPSTORM"

EXPOSE 80
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]