FROM centos:7

# パッケージのインストール
RUN sed -i 's|^mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-*.repo && \
    sed -i 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo
RUN yum install -y openssh-server sudo passwd openssh-clients

# ホスト鍵の作成
RUN ssh-keygen -A

# ユーザー作成 & パスワード設定
RUN useradd -m shadmin && echo "shadmin:password" | chpasswd

# sshd の設定
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

# 公開鍵をユーザーに配布（事前にホスト側からコピー済み）
COPY authorized_keys /home/shadmin/.ssh/authorized_keys

RUN chown -R shadmin:shadmin /home/shadmin/.ssh \
    && chmod 700 /home/shadmin/.ssh \
    && chmod 600 /home/shadmin/.ssh/authorized_keys

# ファイル連携フォルダ作成
RUN mkdir /home/shadmin/dcmftp && mkdir /home/shadmin/dcmftpreturn

EXPOSE 22

# SSH サーバーを起動（ホスト鍵が必要）
CMD ["/usr/sbin/sshd", "-D"]
