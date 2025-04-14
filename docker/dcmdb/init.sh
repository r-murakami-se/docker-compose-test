#!/bin/bash

# MySQL起動（バックグラウンド）
/usr/local/mysql/bin/mysqld_safe --datadir=/usr/local/mysql/data &

# 起動待ち（最大30秒）
for i in {1..30}; do
  if /usr/local/mysql/bin/mysqladmin ping --silent; then
    break
  fi
  sleep 1
done

# rootパスワードを設定
/usr/local/mysql/bin/mysqladmin -u root password "$MYSQL_ROOT_PASSWORD"

# どこからでも接続できる root ユーザー追加
/usr/local/mysql/bin/mysql -uroot -p"$MYSQL_ROOT_PASSWORD" <<EOS
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOS

# データベース作成
/usr/local/mysql/bin/mysql -uroot -p"$MYSQL_ROOT_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS cakephptest DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE IF NOT EXISTS masterkanri DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
EOF

# 初期SQL投入
if [ -f /docker-entrypoint-initdb.d/01_cakephptest.sql ]; then
  /usr/local/mysql/bin/mysql -uroot -p"$MYSQL_ROOT_PASSWORD" cakephptest < /docker-entrypoint-initdb.d/01_cakephptest.sql
fi

if [ -f /docker-entrypoint-initdb.d/02_masterkanri.sql ]; then
  /usr/local/mysql/bin/mysql -uroot -p"$MYSQL_ROOT_PASSWORD" masterkanri < /docker-entrypoint-initdb.d/02_masterkanri.sql
fi

# MySQL停止
pkill mysqld

sleep 3

# MySQLをフォアグラウンドで起動
exec /usr/local/mysql/bin/mysqld_safe --datadir=/usr/local/mysql/data
