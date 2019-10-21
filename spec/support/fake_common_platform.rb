# frozen_string_literal: true

require 'sinatra/base'

class FakeCommonPlatform < Sinatra::Base
  get '/' do
    'fake common platform running'
  end

  get '/core/courts/public/:file_name' do
    json_response(200, '/schemas/global/', params[:file_name])
  end

  get '/core/courts/search/public/:file_name' do
    json_response(200, '/schemas/global/search/', params[:file_name])
  end

  get '/core/courts/search/:file_name' do
    json_response(200, '/schemas/global/', params[:file_name])
  end

  get '/core/courts/global/:file_name' do
    json_response(200, '/schemas/global/', params[:file_name])
  end

  get '/core/courts/global/search/:file_name' do
    json_response(200, '/schemas/global/search/', params[:file_name])
  end

  get '/unified_search_query/global/search/:file_name' do
    json_response(200, '/schemas/global/search/', params[:file_name])
  end

  private

  def json_response(response_code, file_path, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + file_path + file_name).read
  end
end
