class CreateGramInstances < ActiveRecord::Migration
  def self.up
    create_table :gram_instances do |t|
      t.string :to_name, :from_name, :to_email, :from_email, :message
      t.integer :gram_id
      t.timestamps
    end
    add_index :gram_instances, :gram_id
  end

  def self.down
    remove_index :gram_instances, :gram_id
    drop_table :gram_instances
  end
end
