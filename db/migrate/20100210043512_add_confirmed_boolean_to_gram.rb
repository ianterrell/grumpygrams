class AddConfirmedBooleanToGram < ActiveRecord::Migration
  def self.up
    add_column :grams, :confirmed, :boolean
  end

  def self.down
    remove_column :grams, :confirmed
  end
end
