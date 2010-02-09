# This will guess the User class
Factory.define :gram, :default_strategy => :build do |u|
  u.name 'Grump Truck'
  u.slogan  'Beep!  Beep!  Beep!  Is that the Grump Truck?'
end
