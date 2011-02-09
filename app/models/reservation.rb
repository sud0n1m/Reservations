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

  validates :property_id, :presence => true
  validates :from_date, :presence => true, :date => {:after => Time.now }, :property_available => true
  validates :to_date, :presence => true, :date => {:after => :from_date }, :property_available => true
  
# Grabbed this from  https://github.com/challengepost/models/blob/master/lib/models/activerecord/event.rb  
  scope :future, where("from_date > ?", Date.today)
  scope :past, where("from_date < ?", Date.today)
# Grabbed this from http://stackoverflow.com/questions/2716886/rails-trying-to-query-from-a-date-range-everything-from-today/2722004#2722004
  scope :upcoming, where("from_date between ? and ?", Date.today, Date.today.next_month.beginning_of_month)
  
end
