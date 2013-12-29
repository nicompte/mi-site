# encoding: utf-8

require 'sinatra'
require 'slim'
require 'newrelic_rpm'

require './model.rb'

require 'mongoid'
require 'sinatra-authentication'

Mongoid.load!("config/mongoid.yml", :production)

use Rack::Session::Cookie, :secret => 'A1 sauce 1s so good you should use 1t on a11 yr st34ksssss'

#enable :sessions

before do
  content_type :html, 'charset' => 'utf-8'
end

get '/ping' do
  'ok'
end

get '/login' do
  slim :login
end

get '/register' do
  slim :register
end

get '/users' do
  User.each do |user|
    p user.name
  end
end

post '/register' do
  User.create(
    params[:user]
  )
end

get '/*/?' do
  slim :index
end

not_found do
  'Page non trouvée.'
end

error do
  'Erreur - ' + env['sinatra.error']
end
