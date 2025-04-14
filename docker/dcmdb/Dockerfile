FROM centos:7

# CentOS Vault repo に切り替え（CentOS 7の通常ミラーは古くて404になるため）
RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-*.repo && \
    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo

# 必要パッケージのインストール
RUN yum -y install wget gcc gcc-c++ make cmake ncurses-devel bison perl

# MySQL ソースダウンロード＆ビルド
RUN wget https://downloads.mysql.com/archives/get/p/23/file/mysql-5.5.62.tar.gz && \
    tar xzf mysql-5.5.62.tar.gz && \
    cd mysql-5.5.62 && \
    cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
            -DDEFAULT_CHARSET=utf8 \
            -DDEFAULT_COLLATION=utf8_general_ci \
            -DWITH_INNOBASE_STORAGE_ENGINE=1 \
            -DWITH_EXTRA_CHARSETS=all \
            -DSYSCONFDIR=/etc \
            -DMYSQL_DATADIR=/usr/local/mysql/data && \
    make && \
    make install

# MySQL ユーザーとグループの作成
RUN groupadd mysql && useradd -r -g mysql mysql

# データディレクトリ作成と権限設定
RUN mkdir -p /usr/local/mysql/data && \
    chown -R mysql:mysql /usr/local/mysql

# 初期化スクリプトコピー（外部マウントの.sqlが前提なので、実際の初期化は init.sh）
COPY ./init.sh /usr/local/bin/init-mysql.sh
RUN chmod +x /usr/local/bin/init-mysql.sh

# mysql_install_db 実行
RUN /usr/local/mysql/scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data

# 起動スクリプトコピー（使わないかもだが一応）
RUN cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql

# 環境変数パス追加
ENV PATH=/usr/local/mysql/bin:$PATH

# ポートを公開
EXPOSE 3306

# MySQL 初期化＆起動
CMD ["/usr/local/bin/init-mysql.sh"]
