$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'api/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'API'
  s.version     = API::VERSION
  s.authors     = ['Florian Dejonckheere']
  s.email       = ['florian@floriandejonckheere.be']
  s.homepage    = 'https://www.github.com/floriandejonckheere/headbanger'
  s.summary     = 'Headbanger recommendation API'
  s.description = 'Headbanger recommendation API'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.5'

  s.add_dependency 'graph'

  s.add_development_dependency 'sqlite3'
end
