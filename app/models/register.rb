class Register < ActiveRecord::Base
  belongs_to :user
  attr_accessible :amount, :balance_type, :date, :description, :paid

  validates :amount, presence: true
  validates :description, presence: true
  validates :balance_type, presence: true
  validates :date, presence: true

  # Gets all the distinct register's years.
  scope :dates_by_year, Register.select(" DISTINCT ON (date_part('year', date)) date").order("date_part('year', date) DESC")

  # Gets all the distinct register's months by year.
  scope :dates_by_month_and_year, lambda { |year|
    Register.select(" DISTINCT ON (date_part('month', date)) date").where("date_part('year', date) = ? ", year).order("date_part('month', date) DESC")
  }

  # Gets all paid registers by month and year.
  scope :paid_by_month_and_year, lambda { |month, year|
    Register.where("date_part('year', date) = #{ year } and date_part('month', date) = #{ month } and paid = true")
  }

  # Gets all not paid registers by month and year.
  scope :not_paid_by_month_and_year, lambda { |month, year|
    Register.where("date_part('year', date) = #{ year } and date_part('month', date) = #{ month } and balance_type = 'Outgoing' and paid = false")
  }

  BALANCE_TYPE = ['Incoming', 'Outgoing']
  

end
