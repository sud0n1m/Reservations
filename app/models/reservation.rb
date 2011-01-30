# == Schema Information
# Schema version: 20110130004451
#
# Table name: reservations
#
#  id          :integer         not null, primary key
#  email       :string(255)
#  from_date   :date
#  to_date     :date
#  property_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Reservation < ActiveRecord::Base
  attr_accessible :email, :from_date, :to_date, :property_id

  belongs_to :property

  default_scope :order => 'reservations.from_date DESC'

end
