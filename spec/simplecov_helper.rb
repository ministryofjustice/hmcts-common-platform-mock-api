# frozen_string_literal: true

require "simplecov"

SimpleCov.minimum_coverage 100

unless ENV["NOCOVERAGE"]
  SimpleCov.start do
    # formatter SimpleCov::Formatter::HTMLFormatter

    add_filter "spec/"
    add_filter "lib/faker"

    # group functionality for test coverage report
    add_group "Models", "app/models"
    add_group "Controllers", "/app/controllers"
    add_group "Services", "app/services"
  end
end
