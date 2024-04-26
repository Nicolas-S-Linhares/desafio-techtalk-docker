FROM phpstorm/php-73-apache-xdebug-27

ENV ACCEPT_EULA=Y

RUN a2enmod rewrite

#PHP, extensões e outros pacote necessarios
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  libpq-dev \
  libmemcached-dev \
  curl \
  libjpeg-dev \
  libpng-dev \
  libfreetype6-dev \
  libmagickwand-dev \
  libssl-dev \
  libzip-dev \
  libmcrypt-dev \
  poppler-utils -y \
  locales \
  nano \
  curl \
  wget \
  nmap \
  procps \
  tree \
  && rm -r /var/lib/apt/lists/* 

RUN docker-php-ext-configure gd --with-freetype-dir=/usr \
  --with-jpeg-dir=/usr --with-png-dir=/usr \
  && docker-php-ext-install \
  mysqli \
  pdo_mysql \
  gd zip \
  exif
RUN apt update
RUN apt-get install -y \
  locales \
  locales-all

#GRPC
RUN apt-get update \
  && apt-get install -y -q \
  git \
  rake \
  ruby-ronn \
  zlib1g-dev \
  && apt-get clean

RUN cd /usr/local/bin \
  && curl -sS https://getcomposer.org/installer | php

RUN cd /usr/local/bin \
  && mv composer.phar composer

RUN pecl install grpc

RUN docker-php-ext-enable grpc

#SOAP
RUN apt-get update -y \
  && apt install -y \
  libxml2-dev \
  && apt-get clean -y \
  && docker-php-ext-install soap

# wkhtmltopdf
RUN apt-get update \
  && apt-get install -y \
  libxrender1 \
  libfontconfig1 \
  libx11-dev \
  libjpeg62 \
  libxtst6 \
  wget 

RUN mkdir wkhtmltopdf_download \
  && cd wkhtmltopdf_download \
  && wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.stretch_amd64.deb \
  && apt install ./wkhtmltox_0.12.6-1.stretch_amd64.deb -y \
  && cd .. \
  && rm -rf wkhtmltopdf_download

RUN docker-php-ext-install \
  mbstring \
  pdo \
  pdo_mysql

RUN apt-get update \
  && apt-get install -y \
  libc-client-dev \
  libkrb5-dev \
  && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
  && docker-php-ext-install imap

RUN docker-php-ext-configure intl \
  && docker-php-ext-configure gettext \
  && docker-php-ext-install \
  intl \
  gettext

ARG DB_PASS
ARG DB_NAME
ARG DB_USER
ARG DB_HOST

RUN mkdir -p /var/www/html
COPY . /var/www/html

WORKDIR /app

RUN apt update
RUN apt-get install -y openssh-client

COPY --link --chown=33:33 site.conf /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod

#RUN npm install --include=dev
#RUN npm run build

RUN useradd -m myappuser
RUN chown -R myappuser:myappuser /app

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

#IMAGEMAGICK e apache
RUN a2enmod headers expires \
  && apt-get update

RUN apt install -y --no-install-recommends jq \
  && pecl install imagick \
  && docker-php-ext-enable imagick

#EXPOSE 8080
# Não tenho certeza se é a porta 80 ou 8080

ENV DB_PASS=${DB_PASS}
ENV DB_NAME=${DB_NAME}
ENV DB_USER=${DB_USER}
ENV DB_HOST=${DB_HOST}

#CMD ["npm", "start"]