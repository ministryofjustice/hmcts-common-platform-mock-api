# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.6"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0.5"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 6.0"
# Use SCSS for stylesheets
gem "sass-rails", ">= 6"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.11"
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false
gem "cocoon"
gem "factory_bot_rails"
gem "faker"
gem "faraday", "~> 2.7.4"
gem "hmcts_common_platform", github: "ministryofjustice/hmcts_common_platform", tag: "v0.2.0"
gem "json-schema", "~> 2.2.0"
gem "kaminari"
gem "oauth2", "~> 2.0.9"
gem "pg_search"
gem "webpacker"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem "capybara"
  gem "colorize"
  gem "dotenv-rails"
  gem "json-schema-rspec"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 5.1"
  gem "rubocop-govuk", "~> 4.9"
  gem "rubocop-performance", require: false
  gem "sinatra"
  gem "vcr"
  gem "webmock"
end

group :development do
  gem "brakeman"
  gem "listen", ">= 3.0.5", "< 3.9"
end

group :test do
  gem "rspec_junit_formatter"
  gem "shoulda-matchers"
  gem "simplecov"
  gem "webdrivers"
end
