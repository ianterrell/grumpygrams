Factory.define :gram, :default_strategy => :build do |g|
  g.sequence(:name) {|n| "Grump Truck #{n}" }
  g.phrase  'Beep!  Beep!  Beep!  Is that the Grump Truck?'
end