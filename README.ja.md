# middleman-tansu

[![Gem Version](https://badge.fury.io/rb/middleman-tansu.svg)](http://badge.fury.io/rb/middleman-tansu)
[![Build Status](https://travis-ci.org/yterajima/middleman-tansu.svg?branch=develop)](https://travis-ci.org/yterajima/middleman-tansu)

[middleman-tansu](https://github.com/yterajima/middleman-tansu) は Markdown ファイルをディレクトリを使って分類管理するために開発されているテンプレートです。大きく 3 つの機能を提供します。

- `source` ディレクトリ以下の空ディレクトリに `index.html` を生成する機能。この `index.html` は `source/templates/index.html.*` ファイルをもとに `$ middleman server`, `$ middleman build` 時に作られます。tansu テンプレートではカレントディレクトリのディレクトリやファイル一覧とそのリンクを表示します。
- tansu テンプレートの `index.html` やその他のページで使用するためのいくつかのヘルパ。ex. breadcrumbs, children_pages
- tansu テンプレート用の Markdown ファイルを生成する `$ middleman tansu path/to/name` コマンド

## インストール

Add this line to your application's Gemfile:

```ruby
gem 'middleman-tansu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-tansu

## 使い方

bundler の利用を前提に書きます。  
まず新しいプロジェクトを作成しましょう。もちろん使用するテンプレートは tansu です。

```sh
$ middleman init tansu-project --template tansu --skip-bundle
$ cd tansu-project
```

プロジェクトのディレクトリに移動したところで. bundler を使って gem をインストールします。そしてサーバを起動しましょう。

```sh
$ bundle install --path vendor/bundle
$ bundle exec middleman server
```

web ブラウザで `http://localhost:4567` を確認してください。`source` ディレクトリ直下のディレクトリとファイルの一覧が確認できます。

__重要__: 今表示されているページの元ファイルは `source/index.html.*` にあるはずです。確認してみてください。ありません！！

表示されているページは `templates/index.html.slim` を元に [動的ページ](https://middlemanapp.com/jp/advanced/dynamic_pages/) を上手く使って実現しています。`source` 以下のディレクトリ(もちろん `images` や `layouts` のようなものは除いて) で `index.html.*` にあたるものがない場合は自動的に表示されるようになっています。

つまり, あとは好きな様にディレクトリを用意してその中に Markdown ファイルを入れればいいだけです。tansu テンプレートでは Markdown に必須の Frontmatter が 3 つあります。`title`, `author`, `date` です。直接タイプするのは面倒ですね。そこで `$ middleman tansu path/to/name` コマンドが用意されています。

## tansu コマンド

middleman のサーバを停止してからこのコマンドを打ちましょう。`ctrl-c` で停止できます。

```sh
$ bundle exec middleman tansu ディレクトリ/テスト
```

このコマンドを実行すると `source/ディレクトリ/テスト.html.md` が自動生成されます。__"ディレクトリ/テスト"__ の部分に与えた文字列から必要なディレクトリとファイルを作ります。中身を確認してみましょう。だいたいこんな風になっているはずです。

```sh
title: テスト
author: yterajima
date: 2015-01-30 14:00:00 UTC
```

この中で問題になるのが author, date の 2 つです。環境変数によって変化します。author には PC を使用しているユーザ名, date の日時には設定されたタイムゾーン(TZ) を参照して現在時刻を書き出します。

環境変数を `.bashrc` や `.zshrc` に指定することで変更することもできますが, 手っ取り早くコマンド実行時に指定することもできます。例えばタイムゾーンを日本の日時にしたい場合はこのようにコマンドの頭に "TZ=Tokyo" をつけてください。

```sh
$ TZ=Tokyo bundle exec middleman tansu ディレクトリ/テスト
```

タイムゾーンが Tokyo に設定されると次のように date の値が変化します。(UTC から +0900 へ変更)

```sh
title: テスト
author: yterajima
date: 2015-01-30 14:00:00 +0900
```

## Contributing

1. Fork it ( https://github.com/yterajima/middleman-tansu/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
