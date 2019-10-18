# frozen_string_literal: true

require 'sinatra/base'

class FakeCommonPlatform < Sinatra::Base
  get '/' do
    'fake common platform running'
  end

  get '/core/courts/public/:file_name' do
    json_response(200, params[:file_name])
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/schemas/' + file_name).read
  end
end
