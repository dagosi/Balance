class Category < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user
  has_many :registers

  validates_uniqueness_of :name
  validates_presence_of :name

end
