# docker-php7.2
docker install php7.2 include redis swoole memcached mongodb

# run php container
docker run -it --name myphp -p 9000:9000 -v $PWD:/www -d php:7.2

# into php container by /bin/bash
docker run -it  php:7.2-fpm /bin/bash

# docker use nginx
docker pull nginx

docker run -p 80:80 --name mynginx -v $PWD:/www -v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf -v $PWD/logs:/wwwlogs  -d nginx 

# show docker container IP
docker inspect container |grep '"IPAddress"'
