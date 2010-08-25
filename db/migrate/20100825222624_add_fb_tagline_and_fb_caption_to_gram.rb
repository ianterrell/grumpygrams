class AddFbTaglineAndFbCaptionToGram < ActiveRecord::Migration
  def self.up
    add_column :grams, :facebook_tagline, :string
    add_column :grams, :facebook_caption, :string
  end

  def self.down
    remove_column :grams, :facebook_tagline,  :string
    remove_column :grams, :facebook_caption,  :string
  end
end
