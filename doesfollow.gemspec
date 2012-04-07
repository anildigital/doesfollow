require File.expand_path('../lib/doesfollow/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Anil Wadghule"]
  gem.email         = ["anildigital@gmail.com"]
  gem.description   = %q{Simple gem to show 'does follow' status of twitter users.}
  gem.summary       = %q{Simple gem to show 'does follow' status of twitter users}
  gem.homepage      = %q{http://github.com/anildigital/doesfollow}

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "doesfollow"
  gem.require_paths = ["lib"]
  gem.version       = DoesFollow::VERSION


  gem.add_development_dependency(%q<rspec>)
  gem.add_dependency(%q<rest-client>)
  gem.add_dependency(%q<json>)
  
end
