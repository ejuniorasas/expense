class Tag
  include Mongoid::Document

  field :tag, type: String
  
  belongs_to :user

end