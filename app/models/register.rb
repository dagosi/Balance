class Register < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount, :balance_type, :date, :description, :paid

  validates :amount, presence: true
  validates :description, presence: true
  validates :balance_type, presence: true
  validates :date, presence: true

  scope :registers_dates_by_year, Register.select(" DISTINCT ON (date_part('year', date)) date").order("date_part('year', date) DESC")

  BALANCE_TYPE = ['Incoming', 'Outgoing']
  

end
