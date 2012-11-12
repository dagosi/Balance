class Register < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount, :date, :description, :references, :type
end
