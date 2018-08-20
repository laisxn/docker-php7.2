# docker-php7.2
docker install php7.2 include redis swoole memcached mongodb

# run php container
docker run -it --name myphp -p 9000:9000 -v $PWD:/www -d myphp:1.1

# into php container by /bin/bash
docker run -it  php:7.2-fpm /bin/bash
