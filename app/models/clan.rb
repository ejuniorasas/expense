class Clan
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Includes
  
    field :name, type: String
    field :description, type: String
    field :status, type: Integer
    
    has_many :expenses
    has_many :users
    has_many :tags  

end