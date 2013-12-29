require 'mongoid'

class User
  include Mongoid::Document
  field :email, type: String
  field :password, type: String
  embeds_many :pictures
  has_many :users
end

class Picture
  include Mongoid::Document
  field :url
end