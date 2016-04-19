# D1lcs

[![Build Status](https://travis-ci.org/koi-chan/d1lcs-gem.svg?branch=master)](https://travis-ci.org/koi-chan/d1lcs-gem)

でたとこサーガ用1行のキャラクターシート生成ライブラリ

## Installation

プログラムでライブラリとして使うには、Gemfile に以下の行を追加してください。

```ruby
gem 'd1lcs'
```

その後、いつも通りインストールをします。

    $ bundle install

実行ファイルとして使うには以下を実行してシステムにインストールします。

    $ gem install d1lcs

## Usage

TODO: Write usage instructions here

## テスト環境

Travis-CI で、以下のバージョンの ruby でのテストを行なっています。

* 1.9.3
* 2.0.0
* 2.1.10
* 2.2.3
* 2.3.0

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec d1lcs` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/d1lcs.

