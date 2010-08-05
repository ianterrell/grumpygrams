class AddPositionToGrams < ActiveRecord::Migration
  def self.up
    add_column :grams, :position, :integer, :default => 0
  end

  def self.down
    remove_column :grams, :position
  end
end
