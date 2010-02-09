# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_grumpygrams_session',
  :secret      => '7b84aa0c452f9474f60b98b3f3be1b0d0a495b6cb9e60fba2bddf729ba5a60376b2aa29dff6da54f791856e6f663a29dde2e671eb5d4c5401aa0f56d48a5ee3d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
