module API
  class Engine < ::Rails::Engine
    isolate_namespace API

    config.paths.add 'app/api', glob: '**/*.rb'
    config.autoload_paths += %W(#{config.root}/app/api/*)
  end
end
