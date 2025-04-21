docker compose build db1
docker compose build db2
docker compose build web
docker compose up -d web
docker cp web:/root/.ssh/id_rsa.pub ./docker/dcmfile/authorized_keys
docker compose build file
docker compose up -d

docker compose exec web bash -c "ssh-keyscan -H file >> /root/.ssh/known_hosts"
docker compose exec web bash -c "cp /root/.ssh/known_hosts /usr/share/httpd/.ssh/known_hosts"
docker compose exec web bash -c "chmod 600 /usr/share/httpd/.ssh/known_hosts"
docker compose exec web bash -c "chown -R apache:apache /usr/share/httpd/.ssh"
