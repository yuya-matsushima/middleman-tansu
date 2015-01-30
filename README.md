# Middleman::Tansu

[![Gem Version](https://badge.fury.io/rb/middleman-tansu.svg)](http://badge.fury.io/rb/middleman-tansu)
[![Build Status](https://travis-ci.org/yterajima/middleman-tansu.svg?branch=develop)](https://travis-ci.org/yterajima/middleman-tansu)

A template of Middleman to manage Markdown files efficiently. 

## Installation

```ruby
gem 'middleman-tansu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-tansu

## Usage

```sh
$ middleman init PROJECT --template tansu
```

This template(& extension) has `tansu` command. You can create Markdown file.

```sh
$ bundle exec middleman tansu path/to/filename
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/middleman-tansu/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
