class Register < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount, :balance_type, :date, :description
  attr_reader :BALANCE_TYPE

  BALANCE_TYPE = 
    [ { name: 'Incoming', id: 1 }, { name: 'Outgoing', id: 2 }]

end
