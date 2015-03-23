# 0.1.3

- Fix: URI is not encoded in sitemap.xml. 
  マルチバイト文字列を含む URI がエンコードされていなかった問題を修正。
- `-z` option in `tansu` command accepts UPPERCASE or downcase timezone. ex: tokyo, TOKYO
  tansu コマンドのタイムゾーンのオプションは大文字小文字の値を受け付けるようになりました。

# 0.1.2

- Drop `--current` (alias: `-c`) from `tansu` command.
    - This option does't work.(but cucumber test was passed.)

# 0.1.1

- Add option `--current` (alias: `-c`) into `tansu` command.(__DROPPED in v0.1.2__)
    - If you use `-c` option, `tansu` command create file with _relative path_ from current directory.
- Add emoji stylesheet in template.

# 0.1.0

- Release 1st stable version.
- Add command: `$ bundle exec middleman tansu path/to/page_name`.
    - You must use this command with bundler.(`require` problems)
- Add auto index function.
    - Search empty directory that doesn't have `index.html.\*`.
    - Create index.html under these directories using `proxy`.
- Add some helpers.
- Add project template `tansu`.
    - You can use: `$ middleman init PROJECT --template tansu`
