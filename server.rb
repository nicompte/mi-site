# encoding: utf-8

require 'sinatra'
require 'slim'
require 'newrelic_rpm'

before do
  content_type :html, 'charset' => 'utf-8'
end

get '/ping' do
  'ok'
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
