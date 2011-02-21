# == Schema Information
# Schema version: 20110221165300
#
# Table name: properties
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  subdomain  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Property < ActiveRecord::Base
  attr_accessible :name, :subdomain
  belongs_to :user
  
  validates :name,  :presence => true,
    :length => { :maximum => 60 }

  validates :subdomain, :presence => true,
    :uniqueness => { :case_sensitive => false }
    
  validates :user_id, :presence => true

  has_many :reservations, :dependent => :destroy
  
  def available?(date)
    #duplicated from lib/property_available_validator.rb
    Reservation.where(['property_id = ? AND ? BETWEEN from_date AND to_date', id, date]).empty?
  end
  

end


