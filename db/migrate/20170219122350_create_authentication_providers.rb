# frozen_string_literal: true

class CreateAuthenticationProviders < ActiveRecord::Migration
  def change
    create_table 'authentication_providers', :force => true do |t|
      t.string   'name'
      t.string   'display_name'
      t.datetime 'created_at',                 :null => false
      t.datetime 'updated_at',                 :null => false
    end
    add_index 'authentication_providers', ['name'], :name => 'index_name_on_authentication_providers'
    AuthenticationProvider.create(:name => 'facebook', :display_name => 'Facebook')
    AuthenticationProvider.create(:name => 'google_oauth2', :display_name => 'Google')
    AuthenticationProvider.create(:name => 'twitter', :display_name => 'Twitter')
    AuthenticationProvider.create(:name => 'email', :display_name => 'Email')
  end
end
