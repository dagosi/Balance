class Register < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount, :balance_type, :date, :description, :paid

  validates :amount, presence: true
  validates :description, presence: true
  validates :balance_type, presence: true
  validates :date, presence: true

  scope :dates_by_year, Register.select(" DISTINCT ON (date_part('year', date)) date").order("date_part('year', date) DESC")

  scope :dates_by_month_and_year, lambda { |year|
    Register.select(" DISTINCT ON (date_part('month', date)) date").where("date_part('year', date) = ? ", year).order("date_part('month', date) DESC")
  }

  BALANCE_TYPE = ['Incoming', 'Outgoing']
  

end
