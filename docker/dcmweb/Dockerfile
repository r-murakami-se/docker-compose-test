FROM fedora:25

ENV TZ=Asia/Tokyo

# システムをアップデート
RUN dnf update -y

# DNF プラグインのインストール（複数バージョンの管理ができる）
RUN dnf install -y dnf-plugins-core

# PHP と必要な拡張モジュールのインストール
RUN dnf install -y php php-mbstring php-intl php-pdo php-mysqlnd php-xml php-cli

# ApacheとSSLモジュールのインストール
RUN dnf install -y httpd mod_ssl

# zip, unzipのインストール
RUN dnf install -y zip unzip

# dnfキャッシュ削除（イメージサイズ削減）
RUN dnf clean all

# 設定ファイルコピー
COPY httpd.conf /etc/httpd/conf
COPY certs/ /etc/httpd/ssl/
COPY ssl.conf /etc/httpd/conf.d/

# composerインストール
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer

ENV COMPOSER_CACHE_DIR=/tmp/composer

# Apache 起動用コマンド（フォアグラウンドで起動）
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
