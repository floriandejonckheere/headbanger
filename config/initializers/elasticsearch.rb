# frozen_string_literal: true

begin
  Searchkick.client.info
rescue
  abort 'Searchkick not running'
end
