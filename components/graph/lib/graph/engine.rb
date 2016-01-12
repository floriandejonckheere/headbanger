require 'neo4j'
require 'neo4j/railtie'

module Graph
  class Engine < ::Rails::Engine
    isolate_namespace Graph

    config.generators { |g| g.orm :neo4j }

    # Drop module name
    config.neo4j.module_handling = :demodulize
  end
end
