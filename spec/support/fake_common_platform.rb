# frozen_string_literal: true

require 'sinatra/base'

class FakeCommonPlatform < Sinatra::Base
  get '/' do
    'fake common platform running'
  end

  get '/core/courts/:directory/:file_name' do
    json_response(200, '/schemas/global/', params[:file_name])
  end

  get '/core/courts/:directory/search/:file_name' do
    json_response(200, '/schemas/global/search/', params[:file_name])
  end

  get '/core/courts/search/public/:file_name' do
    json_response(200, '/schemas/global/search/', params[:file_name])
  end

  private

  def json_response(response_code, file_path, file_name)
    content_type :json
    status response_code
    file_contents = JSON.parse(File.open(File.dirname(__FILE__) + file_path + file_name).read)

    # We need to rewrite /core/courts/search/public/whatever
    # to match /core/courts/search/global/whatever
    # depending on the location that the schema is referenced from.
    # This is particularly important for courtsDefinitions.json which could
    # be referenced from both urls. The easiest way to do this is by
    # rewriting the path in the "id" attribute
    # for the schema based on the requested path
    file_contents['id'] = url
    file_contents.to_json
  end
end
