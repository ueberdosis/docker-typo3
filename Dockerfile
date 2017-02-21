FROM php:7.1-fpm-alpine
MAINTAINER Patrick Baber <patrick.baber@ueber.io>

# URL: https://typo3.org/download/
ENV TYPO3_VERSION "8.6.0"
ENV TYPO3_SHA256_CHECKSUM "bb766d646e2507af2093a866c058d0e9a341f87505fa0722f73b263112ed2fe5"

# Install dependencies
RUN apk add --update \
    imagemagick \
    openssl \
    wget \
    zlib \
    coreutils \
    freetype-dev \
    libjpeg-turbo-dev \
    libltdl \
    libmcrypt-dev \
    libpng-dev \
    libxml2-dev \
    && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) mysqli soap gd zip && \
    rm  -rf /tmp/* /var/cache/apk/*

# Configure PHP
COPY /etc/php/conf.d/typo3.ini /usr/local/etc/php/conf.d/typo3.ini

# Install TYPO3
RUN mkdir -p /usr/src/typo3 && \
    cd /usr/src/typo3 && \
    wget https://get.typo3.org/${TYPO3_VERSION} -O typo3-${TYPO3_VERSION}.tar.gz && \
    openssl sha256 typo3-${TYPO3_VERSION}.tar.gz | grep "${TYPO3_SHA256_CHECKSUM}" && \
    tar -xzf typo3-${TYPO3_VERSION}.tar.gz && \
    mv /usr/src/typo3/typo3_src-${TYPO3_VERSION} /var/www/html && \
    cd /var/www/html && \
    ln -s typo3_src-* typo3_src && \
    ln -s typo3_src/index.php && \
    ln -s typo3_src/typo3 && \
    ln -s typo3_src/_.htaccess .htaccess && \
    mkdir typo3temp && \
    mkdir typo3conf && \
    mkdir fileadmin && \
    mkdir uploads && \
    touch FIRST_INSTALL && \
    chown -R www-data. . && \
    rm -r /usr/src/typo3

WORKDIR /var/www/html
