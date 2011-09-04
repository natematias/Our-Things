# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ourthings_session',
  :secret      => 'd85ce6976ea9979cd1208cb137a0c5e60f058ac56bb4f2d0ed566847320f3d6917ff9fbf576b474105a7adb243a528ff359209562a81f1446a9941f784444831'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
