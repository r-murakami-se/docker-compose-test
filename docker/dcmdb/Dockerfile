FROM centos:7

# CentOS 7のミラー修正
RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-*.repo && \
    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo && \
    yum clean all

# 必要パッケージとMySQL 5.5のインストール
RUN yum -y install https://downloads.mysql.com/archives/get/p/23/file/MySQL-server-5.5.62-1.el7.x86_64.rpm && \
    yum -y install https://downloads.mysql.com/archives/get/p/23/file/MySQL-client-5.5.62-1.el7.x86_64.rpm && \
    yum -y install expect && \
    yum clean all

# mysqlユーザー作成・パス設定
ENV PATH=/usr/bin:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/local/mysql/bin:$PATH

# ポート公開
EXPOSE 3306

# 起動スクリプト
COPY ./init.sh /usr/local/bin/init-mysql.sh
RUN chmod +x /usr/local/bin/init-mysql.sh

CMD ["/usr/local/bin/init-mysql.sh"]
