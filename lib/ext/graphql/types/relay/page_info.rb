# frozen_string_literal: true

# Add a `count` field to the `pageInfo` object
module Ext
  module GraphQL
    module Types
      module Relay
        module PageInfo
          def self.append_features(mod)
            mod.class_eval do
              field :count,
                    Integer,
                    null: false,
                    description: "Total amount of edges in the connection."

              def count
                object.items.count
              end
            end
          end
        end
      end
    end
  end
end

GraphQL::Types::Relay::PageInfo.include Ext::GraphQL::Types::Relay::PageInfo
