class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin

  has_many :registers

  # Fetch all the registers for a specific year and month.
  def registers_by_date(year, month) 
    self.registers.where("date_part('year', date) = ? and date_part('month', date) = ? ", year, month)
  end

  # Gets all the distinct years for the user's registers.
  def registers_years
    years = []
    self.registers.dates_by_year.map do |register|
      years << register.date.year
    end
    return years
  end

  # Gets all the distinct months for the user's registers.
  # Returns a list of maps, where each map has the id and the name of the month.
  def registers_months(year)
    months = []
    self.registers.dates_by_month_and_year(year).map do |register|
      months << { id: register.date.month, name: register.date.strftime("%B") }
    end
    return months
  end

  # Calculates the total incoming by month and year
  def total_incoming(month, year)
    self.registers.where("date_part('month', date) = #{ month } and date_part('year', date) = #{ year } and balance_type = 'Incoming'").sum(:amount)
  end

  # Calculates the total outgoing by month and year
  def total_outgoing(month, year)
    self.registers.where("date_part('month', date) = #{ month } and date_part('year', date) = #{ year } and balance_type = 'Outgoing'").sum(:amount)
  end

  # Calculates the total balance by month and year
  def balance(month, year)
    total_incoming(month, year) - total_outgoing(month, year)
  end
end
