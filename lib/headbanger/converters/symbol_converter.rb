module Headbanger
module Converters
  class SymbolConverter
    class << self
      def primitive_type
        String
      end

      def convert_type
        Symbol
      end

      def to_db(value)
        value.to_s
      end

      def to_ruby(value)
        value.to_sym
      end
      alias_method :call, :to_ruby
    end

    include Neo4j::Shared::Typecaster
  end
end
end
