class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin

  has_many :registers, dependent: :destroy
  has_many :categories, dependent: :destroy

  # Fetchs all the registers for a specific year and month.
  def registers_by_date(year, month) 
    self.registers.where("date_part('year', date) = #{ year } and date_part('month', date) = #{ month } ").order('created_at DESC')
  end

  # Fetchs all the registers for a specific year.
  def registers_by_year(year) 
    self.registers.where("date_part('year', date) = #{ year }")
  end

  # Gets all the distinct years for the user's registers.
  def registers_years
    years = []
    self.registers.dates_by_year.map do |register|
      years << register.date.year
    end
    logger.info "The distinct years are #{ years }"
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
  def total_incoming_month(month, year)
    self.registers.where("date_part('month', date) = #{ month } and date_part('year', date) = #{ year } and balance_type = 'Incoming'").sum(:amount)
  end

  # Calculates the total outgoing by month and year
  def total_outgoing_month(month, year)
    self.registers.where("date_part('month', date) = #{ month } and date_part('year', date) = #{ year } and balance_type = 'Outgoing'").sum(:amount)
  end

  # Calculates the total balance by month and year
  def total_balance_month(month, year)
    total_incoming_month(month, year) - total_outgoing_month(month, year)
  end

  # Calculates the total incoming by year
  def total_incoming_year(year)
    self.registers.where("date_part('year', date) = #{ year } and balance_type = 'Incoming'").sum(:amount)
  end

  # Calculates the total outgoing by year
  def total_outgoing_year(year)
    self.registers.where("date_part('year', date) = #{ year } and balance_type = 'Outgoing'").sum(:amount)
  end

  # Calculates the total balance by year
  def total_balance_year(year)
    total_incoming_year(year) - total_outgoing_year(year)
  end

  # Calculates all paid registers by month and year
  def total_paid_month(month, year)
    self.registers.paid_by_month_and_year(month, year).sum(:amount)
  end

  # Calculates all not paid registers by month and year
  def total_not_paid_month(month, year)
    self.registers.not_paid_by_month_and_year(month, year).sum(:amount)
  end

  # Calculates the balance types by month, year, and payment type
  def balance_type_by_payment_type(month, year, payment_type, balance_type)
    if payment_type
      self.registers.where("date_part('month', date) = #{ month } and date_part('year', date) = #{ year } and payment_type = '#{ payment_type }' and balance_type = '#{ balance_type }'").sum(:amount)
    end
  end

  # Calculates the balance by month, year, and payment type
  def balance_by_payment_type(month, year, payment_type)
    if payment_type
      incoming = self.registers.where("date_part('month', date) = #{ month } and date_part('year', date) = #{ year } and payment_type = '#{ payment_type }' and balance_type = 'Incoming'").sum(:amount)
      outgoing = self.registers.where("date_part('month', date) = #{ month } and date_part('year', date) = #{ year } and payment_type = '#{ payment_type }' and balance_type = 'Outgoing'").sum(:amount)
      incoming - outgoing
    end
  end

  # Shows the actual ammount of money that a user has.
  def total_money_month(month, year)
    total_incoming_month(month, year) - total_paid_month(month, year)
  end

  def count_registers_by_category(year, month, category_name)
    raise "The month can't be greater than 31" if month.to_i > 31
    self.registers_by_date(year, month).select { |register| register.category.name == category_name }.count
  end

  def calculate_registers_percentage_by_category(year, month)
    total_registers = self.registers_by_date(year, month).count
    categories_percentages = []
    if total_registers > 0
      self.categories.all.each do |category|
        percentage = (self.count_registers_by_category(year, month, category.name).to_f / total_registers) * 100
        if percentage > 0.0
          category_percentage = [category.name, percentage.round(2)]
          categories_percentages << category_percentage
        end
      end
    end
    return categories_percentages
  end

end
