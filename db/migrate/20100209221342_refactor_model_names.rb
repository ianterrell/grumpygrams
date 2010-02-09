class RefactorModelNames < ActiveRecord::Migration
  def self.up
    rename_table(:grams, :gram_template)
    rename_column(:sent_grams, :gram_id, :gram_template_id)
    rename_table(:sent_grams, :grams)
  end

  def self.down
  end
end
