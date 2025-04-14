#!/bin/bash

# 初期化チェック（data/mysql フォルダが空なら初期化）
if [ ! -d "/var/lib/mysql/mysql" ]; then
    /usr/bin/mysqld_safe --datadir=/var/lib/mysql &
    for i in {1..30}; do
        if /usr/bin/mysqladmin ping --silent; then
            break
        fi
        sleep 1
    done

    # rootパスワード設定
    mysqladmin -u root password "${MYSQL_ROOT_PASSWORD}"

    # どこからでも接続できる root ユーザー追加
    mysql -uroot -p"$MYSQL_ROOT_PASSWORD" <<EOS
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOS

    # データベース作成
    mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS cakephptest DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE IF NOT EXISTS masterkanri DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
EOF

    # 初期SQL投入
    [ -f /docker-entrypoint-initdb.d/01_cakephptest.sql ] && \
        mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" cakephptest < /docker-entrypoint-initdb.d/01_cakephptest.sql

    [ -f /docker-entrypoint-initdb.d/02_masterkanri.sql ] && \
        mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" masterkanri < /docker-entrypoint-initdb.d/02_masterkanri.sql

    # MySQL停止
    pkill mysqld
    sleep 3
fi

# Foregroundで起動
exec /usr/bin/mysqld_safe --datadir=/var/lib/mysql
