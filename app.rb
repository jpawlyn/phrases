require 'sinatra'
require 'json/ext'
require_relative 'lib/phrases'
require_relative 'lib/authentication'

before do
  token = params[:token]
  unless Authentication.authenticate token
    halt 401, { unauthorised: true }.to_json
  end
end

get '/phrase' do
  { phrase: Phrases.random_phrase }.to_json
end

post '/phrase/add' do
  body = JSON.parse request.body.read
  Phrases.add_phrase body['phrase']
  { success: true }.to_json
end