# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :redis_store, key: '_stallone_session', redis_server: ENV["REDISCLOUD_URL"] || "redis://127.0.0.1:6379/0/session"