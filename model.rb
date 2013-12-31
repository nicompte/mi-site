require 'mongoid'

class User
  include Mongoid::Document
  field :email, type: String
  field :password, type: String
  embeds_many :pictures
  has_and_belongs_to_many :contacts, :class_name => 'User'
  has_and_belongs_to_many :pendingContacts, :class_name => 'User'
end

class Picture
  include Mongoid::Document
  field :url
end