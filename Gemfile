# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Pg is the Ruby interface to the PostgreSQL RDBMS
gem 'pg'
# Ruby wrapper for hiredis
gem 'hiredis', '~> 0.6.0'
gem 'redis', '>= 3.2.0', require: ['redis', 'redis/connection/hiredis']
# Redis::Namespace class which can be used to namespace Redis keys.
gem 'redis-namespace'
# Keep all your secret files within openssl
gem 'secret-keeper'
# YAML file and a singleton design pattern.
gem 'settingslogic'
# Flexible authentication solution for Rails with Warden
gem 'devise'
# Make Your Rails Console Awesome
gem 'awesome_rails_console'
# Optimized JSON
gem 'oj'
# HTML, XML, SAX, and Reader parsers with XPath and CSS selector support.
gem 'nokogiri'
# Simple, efficient background processing for Ruby
gem 'sidekiq', '5.1.3'
# Official Sass port of Bootstrap 2 and 3.
gem 'bootstrap-sass', '~> 3.2.0'
# Tool to parse CSS and add vendor prefixes to CSS rules
gem 'autoprefixer-rails'
# paginator for Ruby webapps
gem 'kaminari'
# Cron jobs in Ruby
gem 'whenever', require: false
# A gem to automate using jQuery with Rails
gem 'jquery-rails'
# An abstract OAuth2 strategy for OmniAuth.
gem 'omniauth-oauth2', '~> 1.3.1'
# Facebook OAuth2 Strategy for OmniAuth
gem 'omniauth-facebook'
# Oauth2 strategy for Google
gem 'omniauth-google-oauth2'
# OmniAuth strategy for Twitter
gem 'omniauth-twitter'
# A LinkedIn OAuth2 strategy for OmniAuth.
gem 'omniauth-linkedin-oauth2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # pry debug tool
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  # RSpec meta-gem that depends on the other components
  gem 'rspec-rails', '~> 3.7'
  # Code coverage for Ruby 1.9+
  gem 'simplecov', require: false
  # Strategies for cleaning databases in Ruby.
  gem 'database_cleaner'
  # Factory Girl ♥ Rails
  gem 'factory_bot_rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # CLI and Ruby client library for Travis CI
  gem 'travis'
  # Use Capistrano for deployment
  gem 'capistrano', '3.8.0'
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano3-puma', require: false
  # A Ruby static code analyzer, based on the community Ruby style guide.
  gem 'rubocop', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
