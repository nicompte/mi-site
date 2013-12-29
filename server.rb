# encoding: utf-8

require 'sinatra'
require 'slim'
require 'newrelic_rpm'

require './model.rb'

require 'mongoid'

Mongoid.load!("config/mongoid.yml", :production)

enable :sessions

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
  @users = User.all
  slim :users
end

get '/user/:id' do
  @user = User.find(params[:id])
  slim :home
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
