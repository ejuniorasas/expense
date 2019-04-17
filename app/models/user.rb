class User 
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Includes

  field :name, type: String
  field :email, type: String
  field :status, type: Integer
    
  has_many :expenses
  has_many :tags

  belongs_to :clan

end