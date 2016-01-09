module Headbanger
  module WebApp
    class Engine < ::Rails::Engine
      isolate_namespace Headbanger::WebApp
    end
  end
end
