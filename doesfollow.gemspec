require File.expand_path('../lib/doesfollow/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'doesfollow'
  s.version     = '0.5.0'
  s.date        = '2017-10-22'
  s.summary     = "Does follow"
  s.description = "A simple to check does follow status"
  s.authors     = ["Anil Wadghule"]
  s.email       = 'anildigital@gmail.com'
  s.files       = ["lib/doesfollow.rb",
                   "lib/strategies/doesfollow_default.rb",
                   "lib/strategies/doesfollow_console.rb",
                   "lib/doesfollow/twitter_client.rb",
                   "lib/doesfollow/version.rb"]
  s.version       = Doesfollow::VERSION
  s.homepage    =
    'http://rubygems.org/gems/doesfollow'
  s.license       = 'MIT'

  s.add_dependency "oauth", "~> 0.5.3"
  s.add_dependency "json", "~> 2.1"

  s.add_development_dependency "rspec", "~> 3.2"
end
