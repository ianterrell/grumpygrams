class AddAnotherToken < ActiveRecord::Migration
  def self.up
    add_column :grams, :show_token, :string
    rename_column :grams, :url_hash, :confirm_token
  end

  def self.down
    remove_column :grams, :show_token
    rename_column :grams, :confirm_token, :url_hash
  end
end
