---
title: middleman-tansu の簡単な紹介
author: yterajima
date: 2014-01-25 23:32:00 +0900
---

[middleman-tansu](https://github.com/yterajima/middleman-tansu) は Markdown ファイルをディレクトリを使って分類管理するために開発されているテンプレートです。例えるなら静的な wiki のようなものを目指しています。バラバラに管理される Markdown を tansu (箪笥) に入れてまとめて管理できるように工夫されています。

## middleman-tansu が提供する機能

1. `middleman tansu` コマンド
2. 各ディレクトリに `index.html` を用意する機能
3. 自動生成された `index.html` を活用するための Helper
4. プロジェクトテンプレート

### 1.`middleman tansu` コマンド

[middleman-blog](https://github.com/middleman/middleman-blog) のようにコマンドラインからページのひな形を作成することができます。

```sh
$ middleman tansu path/to/ページ
```

このコマンドによって `source/path/to/ページ.html.md` が作成されます。同時にこのテンプレートに必要な Frontmatter を書き込みます。例えば次のようになります。

```
---
title: ページ
author: yterajima
date: 2015-01-31 08:11:22 UTC
---
```

`author` には使用している PC のユーザ名, `date` のシステム上で設定されているタイムゾーンを使って決定しています。もし任意のユーザ名, 任意のタイムゾーンを利用したい場合コマンド実行時に指定することもできます。


### 2.各ディレクトリに `index.html` を用意する機能

大量の Markdown ファイルを管理するには工夫が必要です。

`source` ディレクトリ以下に次のようにディレクトリとファイルが用意されているとしましょう。

```
- source
    - ディレクトリ1
        - ページ1.md.html
        - ページ2.md.html
    - ディレクトリ2
        - index.html.slim
    - templates
        - index.html.slim
```

この状態で `$ middleman server` を実行した場合, `http://localhost:4567` にアクセスしても何も表示されます。また, `http://localhost:4567/ディレクトリ1/` にアクセスしても当然何も表示されません。このまま build & deploy した場合, それぞれのページにたどり着けません。

そこで, middleman-tansu では `index.html` にあたるファイルがない場合, 動的にそのページを生成しそのディレクトリ中のページやディレクトリへのリンクを提供します。

__NOTICE__: `index.html` として出力されるファイルが存在する場合は, middleman-tansu はそのディレクトリに元からあった `index.html` を採用します。

このディレクトリ構成の場合, `source/index.html` と `source/ディレクトリ1/index.html` を自動的に用意します。用意すると言ってもファイルを直接ディレクトリの中に作成する訳ではありません。[動的ページ](https://middlemanapp.com/jp/basics/dynamic-pages/) つまりは `proxy` を使って `$ middleman server`, `$ middleman build` の際にページを出力します。

### 3.自動生成された `index.html` を活用するための Helper

いくつかの Helper を提供しています。主に使われるのは次の 2 つになるでしょう。

- breadcrumbs
    - 表示されているページまでのパンくずリストを表示する
    - layout の中で使われることがほとんどです
- children_pages
    - 現在のページがあるディレクトリ中のファイル/ディレクトリ一覧
    - この Helper は `index.html` になるファイルの中で使われます
- title
    - title タグ中に表示すべき文字列を返す
- heading
    - h1 タグ中に表示すべき文字列を返す

### 4.プロジェクトテンプレート

middleman-tansu は拡張機能と同時にプロジェクトテンプレートを提供しています。次のコマンドで初期化できます。

```sh
$ middleman init PROJECT_NAME --template tansu
```

このまま `$ middleman server` すると基本的な機能が用意されたテンプレートを使うことができます。このテンプレートは github-flavored-markdown を使用することができます。もちろんコードの構文ハイライトも対応します。

