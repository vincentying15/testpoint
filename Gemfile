source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.1'
gem 'rails-i18n', '5.1.1'

# Use postgresql as the database for Active Record
gem 'pg', '1.0.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Libaray
gem 'dotenv-rails', '2.4.0'
gem 'rubocop', require: false
gem 'sentry-raven', '2.7.3'
gem 'hashie', '3.5.7'

# Controllers
gem 'responders', '~> 2.4'

# Models
gem 'devise', '~> 4.3'
gem 'devise-i18n', '1.6.2'
gem 'cancancan', '~> 2.0'
gem "carrierwave", '1.2.2'
gem 'enumerize', '2.2.2'
gem 'ancestry', '3.0.2'
gem "ransack", "2.1.0", require: false

# Views
gem 'simple_form', '4.0.1'
gem 'kaminari', '~> 1.0', '>= 1.0.1'
gem 'fume-nav', '0.1.3'
gem 'jbuilder', '~> 2.5'
gem 'kramdown', '1.17.0'

# Assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '3.5.3'
gem 'coffee-rails', '~> 4.2'

# backgound
gem 'sidekiq', '5.2.6'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'pry-rails', '~> 0.3.6'
  gem "annotate"
  gem 'factory_bot_rails', '~> 4.8'
  gem 'rspec-rails', '~> 3.6'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capsum', '~> 1.1.1', require: false
end

group :test do
  gem 'faker', '~> 1.8', '>= 1.8.2'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '3.0.3'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'

  gem "rails-controller-testing"
  gem "rspec-do_action", "0.0.6"
  gem "shoulda-matchers", "3.1.2"
  gem 'simplecov', require: false
  gem 'coveralls', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'
