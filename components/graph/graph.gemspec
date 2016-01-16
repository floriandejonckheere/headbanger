$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'graph/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'graph'
  s.version     = Graph::VERSION
  s.authors     = ['Florian Dejonckheere']
  s.email       = ['florian@dejonckhee.re']
  s.homepage    = 'https://www.github.com/floriandejonckheere/headbanger'
  s.summary     = 'Graph database backend of Headbanger'
  s.description = 'Graph database backend of Headbanger'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.5'
  s.add_dependency 'neo4j', '~> 6.1.1'
  s.add_dependency 'factory_girl_rails', '~> 4.5.0'
end
