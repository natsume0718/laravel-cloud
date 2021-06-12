FROM php:7.4-fpm

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash
RUN apt-get update \
  && apt-get install -y \
    libwebp-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    git \
    zip unzip \
    nodejs yarn \
    libpq-dev \
    libonig-dev \
    libicu-dev libzip-dev locales \
  && docker-php-ext-install  -j$(nproc) intl bcmath bcmath pdo_mysql opcache gd\
  && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

