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
  
  scope :last_month, -> {where date:( Date.today.last_month.beginning_of_month .. Date.today.last_month.end_of_month)}
  scope :current_month, -> {where date:( Date.today.beginning_of_month .. Date.today.end_of_month)}
  scope :next_month, -> {where date:( Date.today.next_month.beginning_of_month .. Date.today.next_month.end_of_month)}
  
end
