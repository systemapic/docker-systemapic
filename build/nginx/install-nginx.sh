#!/bin/bash

##
# Install NginX with latest SSL
#


die() {
    exit 1
}

cd /tmp/ || die
wget ftp://ftp.openssl.org/source/openssl-1.0.1k.tar.gz || die
tar xvf  openssl-1.0.1k.tar.gz || die
cd openssl-1.0.1k || die
./config --openssldir=/usr/local/openssl || die
make || die
make install || die
sudo ln -sf /usr/local/ssl/bin/openssl /usr/bin/openssl || die

sudo apt-get install -y libpcre3-dev libpcre++-dev || die

cd /tmp/
wget http://nginx.org/download/nginx-1.6.2.tar.gz || die
tar xvf nginx-1.6.2.tar.gz || die
cd nginx-1.6.2 || die
./configure --with-http_ssl_module --with-openssl=/tmp/openssl-1.0.1k --with-cc-opt='-g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -Wl,-z,relro' --prefix=/usr/share/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_addition_module --with-http_dav_module  --with-http_gzip_static_module  --with-http_spdy_module --with-http_sub_module --with-mail --with-mail_ssl_module || die
make || die
make install || die
ln -sf /usr/share/nginx/sbin/nginx  /usr/sbin/nginx || die

mkdir /etc/nginx/sites-enabled || die
mkdir /etc/nginx/ssl || die
mkdir /etc/nginx/error || die
mkdir /etc/nginx/log || die
mkdir /var/lib/nginx || die