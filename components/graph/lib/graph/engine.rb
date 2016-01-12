require 'neo4j/railtie'

module Graph
  class Engine < ::Rails::Engine
    isolate_namespace Graph

    config.generators { |g| g.orm :neo4j }
  end
end
