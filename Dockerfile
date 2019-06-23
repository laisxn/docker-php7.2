FROM php:7.2-fpm

RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
		libmemcached-dev zlib1g-dev \
		libmagickwand-dev \
    		libmagickcore-dev \
		libc-client-devel \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd\
	&& docker-php-ext-install pdo_mysql mysqli soap zip imap bcmath pcntl sockets 
RUN pecl install redis-4.0.1 \
	&& pecl install xdebug-2.6.0 \
	&& pecl install swoole \
	&& pecl install mongodb \
	&& pecl install memcached \
	&& pecl install imagick \
	&& docker-php-ext-enable redis xdebug swoole mongodb memcached imagick opcache
# 增加 imap 扩展 
RUN apt-get update && \
apt-get install -y --no-install-recommends libc-client-dev libkrb5-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
docker-php-ext-install -j$(nproc) imap

# 安装composer并允许root用户运行
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_HOME=/usr/local/share/composer
RUN mkdir -p /usr/local/share/composer \
        && curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
        && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
        && rm -f /tmp/composer-setup.* \
        # 配置composer中国全量镜像
        && composer config -g repo.packagist composer https://packagist.laravel-china.org
        
EXPOSE 9000 
CMD ["php-fpm"]
