# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

ruby '2.3.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.0'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster.
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Flexible authentication solution for Rails with Warden
gem 'devise'
# A simple and straightforward settings solution that uses an ERB enabled
# YAML file and a singleton design pattern.
gem 'settingslogic'
# Make Your Rails Console Awesome
gem 'awesome_rails_console'
# Optimized JSON
gem 'oj'
# HTML, XML, SAX, and Reader parsers with XPath and CSS selector support.
gem 'nokogiri'
# Pg is the Ruby interface to the PostgreSQL RDBMS
gem 'pg'
# Simple, efficient background processing for Ruby
gem 'sidekiq', '4.2.10'
# Official Sass port of Bootstrap 2 and 3.
gem 'bootstrap-sass', '~> 3.2.0'
# Tool to parse CSS and add vendor prefixes to CSS rules
gem 'autoprefixer-rails'
# A Scope & Engine based, clean, powerful, customizable and
# sophisticated paginator for Ruby webapps
gem 'kaminari'
# Cron jobs in Ruby
gem 'whenever', require: false
# A Ruby client library for Redis
gem 'redis', '~> 3.2', require: ['redis', 'redis/connection/hiredis']
# Redis::Namespace class which can be used to namespace Redis keys.
gem 'redis-namespace'
# Minimalistic C client for Redis >= 1.2
gem 'hiredis'
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
# A Ruby static code analyzer, based on the community Ruby style guide.
gem 'rubocop', require: false
# Acceptance test framework for web applications
gem 'capybara'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and debugger
  gem 'byebug', platform: :mri
  # pry debug tool
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  # RSpec meta-gem that depends on the other components
  gem 'rspec'
  gem 'rspec-rails', '~> 3.6'
  # Strategies for cleaning databases in Ruby.
  gem 'database_cleaner', '~> 1.5'
end

group :development do
  # Use Capistrano for deployment
  gem 'capistrano', '3.8.0'
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano3-puma', require: false
  # Access console by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  # Speeds up development by keeping your application running in the background.
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
