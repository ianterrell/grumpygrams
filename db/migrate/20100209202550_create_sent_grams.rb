class CreateSentGrams < ActiveRecord::Migration
  def self.up
    create_table :sent_grams do |t|
      t.string :to_name, :from_name, :limit => 32
      t.string :to_email, :from_email, :message, :limit => 255
      t.integer :gram_id
      t.timestamps
    end
  end

  def self.down
    drop_table :sent_grams
  end
end
