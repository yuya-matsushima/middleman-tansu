# Middleman::Tansu

[![Gem Version](https://badge.fury.io/rb/middleman-tansu.svg)](http://badge.fury.io/rb/middleman-tansu)
[![Build Status](https://travis-ci.org/yterajima/middleman-tansu.svg?branch=develop)](https://travis-ci.org/yterajima/middleman-tansu)

A template of Middleman to manage Markdown files efficiently. 

## Installation

```ruby
gem 'middleman-tansu'
```

And then execute:

```
$ bundle
 # or
$ bundle install --path vendor/bundle # better way
```

Or install it yourself as:

```
$ gem install middleman-tansu
```

## Usage

middleman-tansu is a template of Middleman. This template contain some extensions. 

```
$ middleman init PROJECT --template tansu
```

This template(& extensions) has `tansu` command. You can create Markdown file.

```
$ bundle exec middleman tansu path/to/page_name
```

Then `source/path/to/page_name.html.md` that contain Frontmatter was created. Please start server and acces to `http://localhost:4567`

```
$ bundle exec middleman server
```

You could see directories and pages just below the `source/templates/index.html.slim`. This index page under EMPTY folders is automatically generated. When `source/templates/index.html.slim` is edited, you can change design and functionality of these index pages.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/middleman-tansu/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
