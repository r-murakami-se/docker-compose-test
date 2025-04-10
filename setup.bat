docker compose build dcmdb
docker compose build dcmweb
docker compose up -d dcmweb
docker cp dcm-web:/root/.ssh/id_rsa.pub ./docker/dcmfile/authorized_keys
docker compose build dcmfile
docker compose up -d dcmfile

docker compose exec dcmweb bash -c "ssh-keyscan -H dcmfile >> /root/.ssh/known_hosts"
docker compose exec dcmweb bash -c "cp /root/.ssh/known_hosts /var/www/.ssh/known_hosts"
docker compose exec dcmweb bash -c "chmod 600 /var/www/.ssh/known_hosts"
