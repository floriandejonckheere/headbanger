module Graph
  module Virtualizable
    extend ActiveSupport::Concern

    included do
      attributes.each_key do |key|
        alias_method "graph_#{key}".to_sym, key.to_sym
        define_method(key.to_sym) do
          # Check cache validity
          send "graph_#{key}".to_sym
        end
      end
    end
  end
end
