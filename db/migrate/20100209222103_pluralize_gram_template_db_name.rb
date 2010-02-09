class PluralizeGramTemplateDbName < ActiveRecord::Migration
  def self.up
    rename_table(:gram_template, :gram_templates)
  end

  def self.down
  end
end
