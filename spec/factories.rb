
Factory.define :gram_template, :default_strategy => :build do |u|
  u.name 'Grump Truck'
  u.slogan  'Beep!  Beep!  Beep!  Is that the Grump Truck?'
end

Factory.define :gram, :default_strategy => :build do |u|
  u.to_name 'Huggy'
  u.from_name 'Bear'
  u.to_email 'boner@boner.com'
  u.from_email 'limp@penis.com'
  u.message 'OMG THIS IS SO U!'
  u.association :gram_template
end
