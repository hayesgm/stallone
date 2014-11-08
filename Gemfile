source 'https://rubygems.org'

gem 'rails', '4.1.4'

gem 'pg' # Use postgresql as the database for Active Record

gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder

gem 'puma' # Use puma as the app server

### Assets

# Coffeescript
gem 'coffee-rails', '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Jquery
gem 'jquery-rails'

# Fonts
gem 'font-awesome-rails'

# Haml / Sass
gem 'sass-rails', '~> 4.0.3' # Use SCSS for stylesheets
gem 'haml'
gem 'haml-rails', group: :development
gem 'bootstrap-sass'
gem 'autoprefixer-rails'

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :development do
  gem 'spring' # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
end

group :test do
  gem 'database_cleaner'
end

group :doc do
  gem 'sdoc', '~> 0.4.0' # bundle exec rake doc:rails generates the API under doc/api.
end

group :staging, :production do
  gem 'rails_12factor'
end

# Error handling
gem "bugsnag"

# Mixpanel Analytics
gem 'mixpanel-ruby'

# Vignette
gem 'vignette'

# Qonf
gem 'qonf'

# Twilio
gem 'twilio-ruby'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use debugger
# gem 'debugger', group: [:development, :test]