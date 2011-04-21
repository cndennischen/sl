# Be sure to restart your server when you modify this file.

SketchLab::Application.config.session_store :cookie_store,
  :key => '_SketchLab_session',
  :expire_after => 2.weeks # Session cookies expire after two weeks

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# SketchLab::Application.config.session_store :active_record_store
