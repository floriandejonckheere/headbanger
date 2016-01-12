module API
  module Error
    class NotFoundError < StandardError; end
    class InvalidParameterError < StandardError; end
  end
end
