# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_beetlebug_session',
  :secret      => '92b2e52ee46c15d51349c6ce2b8dda62c83496b64058bbfc23621e1c07900e9abe20f9048b207b08cfe889863a251360b63eb79403b21ab5e72f31f53c54806f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
