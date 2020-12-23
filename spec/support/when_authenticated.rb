# frozen_string_literal: true

RSpec.shared_context "When authenticated" do
  before do
    authenticate
  end

  def authenticate
    if page.driver.browser.respond_to?(:authorize)
      page.driver.browser.authorize(username, password)
    else
      visit "http://#{username}:#{password}@#{host}:#{port}/admin/prosecution_cases"
    end
  end

  def username
    ENV["ADMIN_USERNAME"]
  end

  def password
    ENV["ADMIN_PASSWORD"]
  end

  def host
    Capybara.current_session.server.host
  end

  def port
    Capybara.current_session.server.port
  end
end
