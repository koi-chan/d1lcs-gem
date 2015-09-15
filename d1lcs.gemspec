# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'd1lcs/version'

Gem::Specification.new do |spec|
  spec.name          = "d1lcs"
  spec.version       = D1lcs::VERSION
  spec.licenses      = ['MIT']
  spec.authors       = ["koi-chan"]
  spec.email         = ["koi-chan@mail.kazagakure.net"]

  spec.summary       = %q{でたとこサーガ用1行キャラクターシート出力}
  spec.description   = %q{TRPG『でたとこサーガ』用の1行キャラクターシートを生成します。}
  spec.homepage      = "https://github.com/koi-chan/d1lcs-gem"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
