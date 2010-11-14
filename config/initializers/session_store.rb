# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_deliverables_schedule_session',
  :secret      => '1a6a8d97f731f1913d732c86e1d676c47c3331ddda63f15771ec01f07f44c0633b52bb2292d3a1a0ef8c2896ad4a3c7e5cd694afda15f4124af8a3e1475c0696'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
