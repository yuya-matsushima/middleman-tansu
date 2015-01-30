# middleman-tansu

[![Gem Version](https://badge.fury.io/rb/middleman-tansu.svg)](http://badge.fury.io/rb/middleman-tansu)
[![Build Status](https://travis-ci.org/yterajima/middleman-tansu.svg?branch=develop)](https://travis-ci.org/yterajima/middleman-tansu)

[middleman-tansu](https://github.com/yterajima/middleman-tansu) はディレクトリで Markdown を作成・管理するテンプレートです。例えば静的な wiki のようなもの, あなたやあなたのチームのコードスニペット管理ツールとして利用できます。

## インストール

Gemfile に次の 1 行を追加してください。

```ruby
gem 'middleman-tansu'
```

bundler のコマンドを実行してインストールします。middleman-tansu は Middleman やその依存する gem のバージョンに大きく依存しています。各ディレクトリのローカルにインストールするのがいいでしょう。

```
$ bundle
  # or
$ bundle install --path vendor/bundle
```

もしくは直接 gem コマンドでインストールしてください。

```
$ gem install middleman-tansu
```

## 使い方

middleman-tansu は拡張機能を含んだテンプレートです。利用するには Middleman プロジェクトの初期化時に指定します。

```
$ bundle exec middleman init PROJECT_NAME --template tansu
$ cd PROJECT_NAME
```

middleman-tansu に適した Markdown ファイルを作るために次のコマンドが用意されています。

```
$ bundle exec middleman tansu path/to/page_name
```

このコマンドを実行すると middleman-tansu に適した形の Frontmatter を含んだ `source/path/to/page_name.html.md` が作成されます。

ファイルを作ったらサーバを起動して web ブラウザで `http://localhost:4567` にアクセスしてみましょう。

```
$ bundle exec middleman server
```

`source` 直下のディレクトリとファイルの一覧が表示されるかと思います。この一覧は各ディレクトリごとに自動生成される仕組みです。もし特定のディレクトリ直下のページでは異なったデザインにしたい場合, `source/templates/index.html.slim` をそのディレクトリにコピーして編集してください。

もちろん `source/templates/index.html.slim` を編集することで自動生成されるページの内容を変更することができます。

## Contributing

1. Fork it ( https://github.com/yterajima/middleman-tansu/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
