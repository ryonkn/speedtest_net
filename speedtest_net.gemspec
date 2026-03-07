# frozen_string_literal: true

require_relative 'lib/speedtest_net/version'

Gem::Specification.new do |spec|
  spec.name = 'speedtest_net'
  spec.version = SpeedtestNet::VERSION
  spec.authors = ['Ryo Nakano']
  spec.email = ['ryo.z.nakano@gmail.com']

  spec.summary = 'Library for testing internet bandwidth using speedtest.net'
  spec.description = 'Library for testing internet bandwidth using speedtest.net'
  spec.homepage = 'https://github.com/ryonkn/speedtest_net'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rexml', '~> 3.2'
  spec.add_dependency 'typhoeus', '~> 1.4.1'
end
