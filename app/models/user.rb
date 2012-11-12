class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :admin

  has_many :registers

  def total_incoming
    self.registers.where(balance_type: 'Incoming').sum(:amount)
  end

  def total_outgoing
    self.registers.where(balance_type: 'Outgoing').sum(:amount)
  end

  def balance
    total_incoming - total_outgoing
  end
end
