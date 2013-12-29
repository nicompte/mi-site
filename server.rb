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

post 'login' do
  @user = User.where(:email => params[:email])
  if @user.exists? && @user.password == params[:password]
    session[:user] = @user
    redirect "/user/#{@user.id}"
  else
    redirect '/login'
  end
end

get '/register' do
  slim :register
end

get '/users' do
  @users = User.all
  slim :users
end

get '/user/:id' do
  if session[:user].nil?
    redirect '/login'
  end
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
