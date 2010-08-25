class AddRecipientPhraseToGram < ActiveRecord::Migration
  def self.up
    add_column :grams, :recipient_phrase, :string
  end

  def self.down
    remove_column :grams, :recipient_phrase,  :string
  end
end
