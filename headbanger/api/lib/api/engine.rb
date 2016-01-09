module Headbanger
  module API
    class Engine < ::Rails::Engine
      isolate_namespace Headbanger::API
    end
  end
end
