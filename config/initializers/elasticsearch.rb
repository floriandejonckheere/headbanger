# frozen_string_literal: true

begin
  Searchkick.client.info
rescue
  Rails.logger.error 'ElasticSearch not running'
  abort
end
