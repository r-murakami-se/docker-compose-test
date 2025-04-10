FROM fedora:25

ENV TZ=Asia/Tokyo

# 1. システムをアップデート
RUN dnf update -y

# 2. Remi リポジトリの有効化
#RUN dnf install -y https://rpms.remirepo.net/fedora/remi-release-25.rpm

# 3. DNF プラグインのインストール（複数バージョンの管理ができる）
RUN dnf install -y dnf-plugins-core

# 4. PHP 7.0 を有効化
#RUN dnf config-manager --set-enabled remi-php70

# 5. PHP と必要な拡張モジュールのインストール
RUN dnf install -y php php-mbstring php-intl php-pdo php-mysqlnd php-xml php-cli

# Apacheのインストール
RUN dnf install -y httpd

# 設定ファイルコピー
COPY httpd.conf /etc/httpd/conf

# composerインストール
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer

# Apache 起動用コマンド（フォアグラウンドで起動）
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
