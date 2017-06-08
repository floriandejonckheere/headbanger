# frozen_string_literal: true

class ForceCreateIdentityProviderIndex < Neo4j::Migrations::Base
  def up
    add_index :Identity, :provider, :force => true
  end

  def down
    drop_index :Identity, :provider
  end
end
