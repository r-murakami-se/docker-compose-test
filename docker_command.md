# docker command list

## よく使うコマンド

### コンテナ起動

`docker compose start`

### コンテナ停止

`docker compose stop`

### 起動中コンテナ確認

`docker compose ps`

※ `-a` オプションで全コンテナ確認

### コンテナに入りコマンド実行

`docker compose exec [SERVICE名] bash`

※ SERVICE名 = コンテナ確認コマンドで表示された「SERVICE」値

※ `exit` で退出

### コンテナにコマンド即時実行

`docker compose exec [SERVICE名] [実行コマンド]`

※ CakePHPのhtml\src\Shell\TestShell.phpシェルを実行する場合

`docker compose exec dcmweb /var/www/html/bin/cake test`

## あまり使わないコマンド

### コンテナ削除

`docker compose down`

※ `-v` DBや作成ファイルなどの永続データも含めて削除

※ Docker構成など修正する際に使用（通常はstopで停止でOK）

### コンテナ再構築して起動

`docker compose up -d`

※ コンテナ削除後、または初期起動時に使用

※ `docker compose stop` 後は再構築せず起動のみ

※ Dockerイメージなどに変更があれば再構築して起動する場合あり

※ `--build` オプション付きの場合、強制的に再ビルド（Dockerfileの修正後など）

### コンテナのログ確認

`docker compose logs [SERVICE名]`

※ 構築時などでエラーが起こった際に確認する
