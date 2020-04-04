# frozen_string_literal: true

begin
  Searchkick.client.info
rescue StandardError
  Rails.logger.error "ElasticSearch not running"
  abort
end
