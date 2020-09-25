# frozen_string_literal: true

Capybara.configure do |config|
  config.javascript_driver = :selenium_chrome_headless
end

driver_urls = Webdrivers::Common.subclasses.map(&:base_url)

WebMock.disable_net_connect!(allow_localhost: true, allow: driver_urls)
