# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.4"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 8.0", ">= 8.0.5.2"
# Use postgresql as the database for Active Record
gem "pg", ">= 1.4.5", "< 2.0"
gem "propshaft", ">= 1.3.2"
# Use Puma as the app server
gem "puma", "~> 7.0.4"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.15", ">= 2.15.0"
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem "actionpack", "~> 8.0", ">= 8.0.5.2"
gem "actionview", "~> 8.0", ">= 8.0.5.2"
gem "activemodel", "~> 8.0", ">= 8.0.5.2"
gem "activerecord", "~> 8.0", ">= 8.0.5.2"
gem "activesupport", "~> 8.0", ">= 8.0.5.2"
gem "railties", "~> 8.0", ">= 8.0.5.2"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false
gem "csv"
gem "dry-validation"
gem "factory_bot_rails"
gem "faker"
gem "faraday", "~> 2.13.4"
gem "hmcts_common_platform", github: "ministryofjustice/hmcts_common_platform", tag: "v0.2.0"
gem "json-schema", git: "https://github.com/voxpupuli/json-schema", branch: "master", ref: "081dfc3"
gem "kaminari", ">= 1.3.0"
gem "oauth2", "~> 2.0.18"
gem "pg_search", ">= 2.3.8"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem "capybara"
  gem "colorize"
  gem "dotenv-rails", ">= 3.2.0"
  gem "json-schema-rspec", "~> 0.0.4"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 8.0.3"
  gem "rubocop-govuk", "~> 5.2", ">= 5.2.0"
  gem "rubocop-performance", require: false
  gem "sinatra", ">= 4.2.0"
  gem "vcr"
  gem "webmock"
end

group :development do
  gem "brakeman"
  gem "listen", ">= 3.0.5", "< 3.10"
end

group :test do
  gem "rspec_junit_formatter"
  gem "shoulda-matchers", ">= 7.0.1"
  gem "simplecov"
  gem "webdrivers"
end

gem "cssbundling-rails", "~> 1.4"

gem "jsbundling-rails", "~> 1.3"
