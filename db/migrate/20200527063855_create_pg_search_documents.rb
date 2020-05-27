# frozen_string_literal: true

class CreatePgSearchDocuments < ActiveRecord::Migration[6.0]
  def self.up
    say_with_time("Creating table for pg_search multisearch") do
      create_table :pg_search_documents, id: :uuid do |t|
        t.text :content
        t.belongs_to :searchable, polymorphic: true, index: true, type: :uuid

        t.timestamps
      end
    end
  end

  def self.down
    say_with_time("Dropping table for pg_search multisearch") do
      drop_table :pg_search_documents
    end
  end
end
