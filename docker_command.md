# docker command list

## コンテナ起動

`docker compose start`

## コンテナ停止

`docker compose stop`

## 起動中コンテナ確認

`docker compose ps`

## 全コンテナ確認

`docker compose ps -a`

## コンテナ内でコマンド実行

`docker compose exec [SERVICE名] bash`

※ `exit` で退出

## コンテナ削除

`docker compose down -v`

※ `-v` DBなどの永続データも含めて削除
※ Docker構成など修正する際に使用

## コンテナ再構築して起動

`docker compose up -d`

※ コンテナ削除後、または初期起動時に使用
※ `docker compose stop` 後は再構築せず起動のみ
※ Dockerイメージなどに変更があれば再構築して起動する場合あり
※ `--build` オプション付きの場合、強制的に再ビルド（Dockerfileの修正後など）
