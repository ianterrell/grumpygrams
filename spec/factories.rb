Factory.define :gram, :default_strategy => :build do |g|
  g.sequence(:name) {|n| "Grump Truck #{n}" }
  g.phrase  'Beep!  Beep!  Beep!  Is that the Grump Truck?'
end

Factory.define :gram_instance, :default_strategy => :build do |g|
  g.to_name 'Huggy'
  g.from_name 'Bear'
  g.to_email 'boner@boner.com'
  g.from_email 'limp@penis.com'
  g.message 'OMG THIS IS SO U!'
  g.association :gram
end
