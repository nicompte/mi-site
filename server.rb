# encoding: utf-8

require 'sinatra'
require "json"
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

post '/login' do
  @user = User.where(email: params[:user]["email"])
  if @user.exists? && @user.first[:password] == params[:user]["password"]
    session[:user] = @user.first
    redirect "/home"
  else
    redirect '/login'
  end
end

get '/logout' do
  session[:user] = nil
  redirect "/"
end

get '/register' do
  slim :register
end

get '/users' do
  @users = User.all
  slim :users
end

get '/home' do
  redirect '/login' if session[:user].nil?
  @user = User.find(session[:user][:_id])
  slim :home
end

post '/user/:id/add_contact' do |id|
  redirect '/login' if session[:user].nil?
  user = User.find(id)
  params[:contacts].split(',').each do |contact|
    User.find(contact).pendingContacts.push(user)
  end
  redirect '/home'
end

get '/user/:id/validate_contact/:contact_id' do |id, contact_id|
  redirect '/login' if session[:user].nil?
  user = User.find(id)
  contact = User.find(contact_id)
  user.pendingContacts.delete(contact)
  contact.contacts.push(user)
  user.contacts.push(contact)
  redirect '/home'
end

get '/user/:id/refuse_contact/:contact_id' do |id, contact_id|
  redirect '/login' if session[:user].nil?
  user = User.find(id)
  contact = User.find(contact_id)
  user.pendingContacts.delete(contact)
  redirect '/home'
end

get '/user/:id/remove_contact/:contact_id' do |id, contact_id|
  redirect '/login' if session[:user].nil?
  user = User.find(id)
  contact = User.find(contact_id)
  user.contacts.delete(contact)
  contact.contacts.delete(user)
  redirect '/home'
end

get '/users/find' do
  puts params[:q]
  content_type :json
  User.where(email: Regexp.new(params[:q])).to_json
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
