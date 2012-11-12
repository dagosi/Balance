class Register < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount, :balance_type, :date, :description
  attr_reader :BALANCE_TYPE

  validates :amount, presence: true
  validates :description, presence: true
  validates :balance_type, presence: true
  validates :date, presence: true

  BALANCE_TYPE = 
    [ { name: 'Incoming', id: 1 }, { name: 'Outgoing', id: 2 }]
end
