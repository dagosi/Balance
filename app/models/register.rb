class Register < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount, :balance_type, :date, :description
end
