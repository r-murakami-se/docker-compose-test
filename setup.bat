docker compose build dcmweb
docker compose up -d dcmweb
docker cp dcm-web:/root/.ssh/id_rsa.pub ./docker/dcmfile/authorized_keys
docker compose build dcmfile
docker compose up -d

docker compose exec dcmweb bash -c "ssh-keyscan -H dcmfile >> /root/.ssh/known_hosts"
docker compose exec dcmweb bash -c "cp /root/.ssh/known_hosts /usr/share/httpd/.ssh/known_hosts"
docker compose exec dcmweb bash -c "chmod 600 /usr/share/httpd/.ssh/known_hosts"
docker compose exec dcmweb bash -c "chown -R apache:apache /usr/share/httpd/.ssh"
