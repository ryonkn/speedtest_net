# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'speedtest_net/version'

Gem::Specification.new do |spec|
  spec.name          = 'speedtest_net'
  spec.version       = SpeedtestNet::VERSION
  spec.authors       = ['Ryo Nakano']
  spec.email         = ['ryo@ryonkn.com']

  spec.summary       = 'Library for testing internet bandwidth using speedtest.net'
  spec.description   = 'Library for testing internet bandwidth using speedtest.net'
  spec.homepage      = 'https://github.com/ryonkn/speedtest_net'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'codacy-coverage', '~> 2.1'
  spec.add_development_dependency 'factory_bot', '~> 5.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.76'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.36'
  spec.add_development_dependency 'simplecov', '~> 0.17'
  spec.add_development_dependency 'vcr', '~> 5.0'
  spec.add_development_dependency 'webmock', '~> 3.7'

  spec.add_dependency 'curb', '~> 0.9'
  spec.add_dependency 'typhoeus', '~> 1.3'
end
