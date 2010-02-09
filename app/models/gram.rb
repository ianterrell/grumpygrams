class Gram < ActiveRecord::Base
  validates_presence_of :name, :slogan
end
