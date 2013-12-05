require 'mongoid'

class Person
  include Mongoid::Document
  field :email, type: String
  field :password, type: String
  embeds_many :pictures
  has_many :persons
end