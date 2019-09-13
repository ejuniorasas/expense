class Expense
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Includes

  field :name, type: String
  field :description, type: String
  field :value, type: Float
  field :status, type: Integer
  field :date, type: Date
  field :tags, type: Array

  belongs_to :clan
  belongs_to :user
  
  scope :filter_month, ->(date_filter, current_clan) {where date:( date_filter.beginning_of_month .. date_filter.end_of_month), clan: current_clan}


end
