# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.4"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 8.0"
# Use postgresql as the database for Active Record
gem "pg", ">= 1.4.5", "< 2.0"
gem "propshaft"
# Use Puma as the app server
gem "puma", "~> 6.6.1"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.14"
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem "actionpack", "~> 8.0"
gem "actionview", "~> 8.0"
gem "activemodel", "~> 8.0"
gem "activerecord", "~> 8.0"
gem "activesupport", "~> 8.0"
gem "railties", "~> 8.0"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false
gem "cocoon"
gem "csv"
gem "dry-validation"
gem "factory_bot_rails"
gem "faker"
gem "faraday", "~> 2.13.4"
gem "hmcts_common_platform", github: "ministryofjustice/hmcts_common_platform", tag: "v0.2.0"
gem "json-schema", git: "https://github.com/voxpupuli/json-schema", branch: "master", ref: "081dfc3"
gem "kaminari"
gem "oauth2", "~> 2.0.14"
gem "pg_search"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem "capybara"
  gem "colorize"
  gem "dotenv-rails"
  gem "json-schema-rspec", "~> 0.0.4"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 8.0.2"
  gem "rubocop-govuk", "~> 5.1"
  gem "rubocop-performance", require: false
  gem "sinatra"
  gem "vcr"
  gem "webmock"
end

group :development do
  gem "brakeman"
  gem "listen", ">= 3.0.5", "< 3.10"
end

group :test do
  gem "rails-controller-testing"
  gem "rspec_junit_formatter"
  gem "shoulda-matchers", ">= 6.0.0"
  gem "simplecov"
  gem "webdrivers"
end

gem "cssbundling-rails", "~> 1.4"

gem "jsbundling-rails", "~> 1.3"
