class RemoveExtraFieldsFromGramInstance < ActiveRecord::Migration
  def self.up
    remove_column :gram_instances, :to_name,    :string
    remove_column :gram_instances, :from_name,    :string
    remove_column :gram_instances, :to_email,    :string
    remove_column :gram_instances, :from_email,    :string
  end

  def self.down
    add_column :gram_instances, :to_name,    :string
    add_column :gram_instances, :from_name,    :string
    add_column :gram_instances, :to_email,    :string
    add_column :gram_instances, :from_email,    :string
  end
end
