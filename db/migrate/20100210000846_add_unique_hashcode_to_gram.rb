class AddUniqueHashcodeToGram < ActiveRecord::Migration
  def self.up
    add_column :grams, :url_hash, :string
  end

  def self.down
    remove_column :grams, :url_hash
  end
end
