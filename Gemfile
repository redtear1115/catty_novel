source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
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
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
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
# A simple and straightforward settings solution that uses an ERB enabled YAML file and a singleton design pattern.
gem 'settingslogic'
# Make Your Rails Console Awesome
gem 'awesome_rails_console'
# Optimized JSON
gem 'oj'
# Nokogiri (鋸) is a Rubygem providing HTML, XML, SAX, and Reader parsers with XPath and CSS selector support.
gem 'nokogiri'
# Pg is the Ruby interface to the PostgreSQL RDBMS
gem 'pg'
# Simple, efficient background processing for Ruby
gem 'sidekiq', '4.2.10'
# Official Sass port of Bootstrap 2 and 3.
gem 'bootstrap-sass', '~> 3.2.0'
# Tool to parse CSS and add vendor prefixes to CSS rules
gem 'autoprefixer-rails'
# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Ruby webapps
gem 'kaminari'
# Cron jobs in Ruby
gem 'whenever', :require => false
# This gem adds a Redis::Namespace class which can be used to namespace Redis keys.
gem 'redis-namespace'

gem 'jquery-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # pry debug tool
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'
  # RSpec meta-gem that depends on the other components
  gem 'rspec'
  gem 'rspec-rails', '~> 3.5'
  # Strategies for cleaning databases in Ruby.
  gem 'database_cleaner', '~> 1.5'
end

group :development do
  # Use Capistrano for deployment
  gem 'capistrano', '3.8.0'
  gem 'capistrano-rvm', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-sidekiq', require: false
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
