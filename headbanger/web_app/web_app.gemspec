$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'web_app/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'web_app'
  s.version     = Headbanger::WebApp::VERSION
  s.authors     = ['Florian Dejonckheere']
  s.email       = ['florian@floriandejonckheere.be']
  s.homepage    = 'https://www.github.com/floriandejonckheere/headbanger'
  s.summary     = 'Headbanger web frontend'
  s.description = 'Headbanger web frontend'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.5'

  s.add_dependency 'api'

  s.add_development_dependency 'sqlite3'
end
