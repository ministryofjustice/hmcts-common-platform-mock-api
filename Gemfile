# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.10'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false
gem 'cocoon'
gem 'factory_bot_rails'
gem 'faker'
gem 'faraday_middleware'
gem 'hmcts_common_platform', github: 'ministryofjustice/hmcts_common_platform', tag: '0.1.0'
gem 'json-schema'
gem 'kaminari'
gem 'oauth2'
gem 'pg_search'
gem 'webpacker'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'capybara'
  gem 'dotenv-rails'
  gem 'json-schema-rspec'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 4.0'
  gem 'rubocop', '~> 1.3', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'sinatra'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'webdrivers'
end
