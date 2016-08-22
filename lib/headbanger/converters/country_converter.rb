module Headbanger
module Converters
  class CountryConverter
    class << self
      def primitive_type
        String
      end

      def convert_type
        ISO3166::Country
      end

      def to_db(value)
        value.alpha3
      end

      def to_ruby(value)
        ISO3166::Country[value]
      end
      alias_method :call, :to_ruby
    end

    include Neo4j::Shared::Typecaster
  end
end
end
