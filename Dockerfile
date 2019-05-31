FROM debian
ADD Dockerlab.list /etc/apt/sources.list.d/
RUN apt-get update && apt-get -y upgrade && apt -y install nginx && \
apt-get clean && cd /var/www/ && rm -rf ./* && mkdir -p Dockerlab.com/img && \
chmod -R 754 /var/www/Dockerlab.com/ && useradd Artem && groupadd Maslennikov && \
usermod -aG Maslennikov Artem && chown -R Artem:Maslennikov /var/www/Dockerlab.com/ && \
sed -i 's!/var/www/html!/var/www/Dockerlab.com!g' /etc/nginx/sites-enabled/default && \
sed -i 's!user www-data!user Artem!g' /etc/nginx/nginx.conf
ADD index.html /var/www/Dockerlab.com/
ADD img.jpg /var/www/Dockerlab.com/img/
CMD ["nginx", "-g", "daemon off;"]
