class CreateGrams < ActiveRecord::Migration
  def self.up
    create_table :grams do |t|
      t.string :name, :limit => 64
      t.string :slogan, :limit => 255
      t.timestamps
    end
  end

  def self.down
    drop_table :grams
  end
end
