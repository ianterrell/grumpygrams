class AddUserFieldstoGramInstance < ActiveRecord::Migration
  def self.up
    add_column :gram_instances, :user_id,    :integer
    add_column :gram_instances, :recipient_facebook_uid,    :integer
  end

  def self.down
    remove_column :gram_instances, :user_id,    :integer
    remove_column :gram_instances, :recipient_facebook_uid,    :integer
  end
end
