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
