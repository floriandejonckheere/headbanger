# frozen_string_literal: true

module Converters
  module MetalArchives
    class NilDateConverter
      class << self
        def primitive_type
          String
        end

        def convert_type
          ::MetalArchives::NilDate
        end

        def to_db(value)
          value.to_s
        end

        def to_ruby(value)
          if value.instance_of? ::MetalArchives::NilDate
            value
          else
            ::MetalArchives::NilDate.parse value
          end
        end
        alias :call :to_ruby
      end

      include Neo4j::Shared::Typecaster
    end
  end
end
