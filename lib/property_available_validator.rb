class PropertyAvailableValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    object.errors[attribute] << ' not available' unless
      Reservation.where(['property_id = ? AND ? BETWEEN from_date AND to_date', object.property_id, value]).empty?
  end
end

# Source: http://stackoverflow.com/questions/4774974/rails-is-a-date-between-two-dates
# class TripdateValidator < ActiveModel::EachValidator
# 
#   def validate_each(object, attribute, value)
# 
#       # Check value exists as end_date is optional
#       if value != nil
# 
#           parsed_date = Date.parse(value)
# 
#           # is the start date within the range of anything in the db
#          trips = Trip.where(['start_date >= ? AND end_date <= ? AND user_id = ?', parsed_date, parsed_date, object.user_id])
# 
#         # overlapping other trips, aghhh
#         object.errors[attribute] << 'oh crap' if trips
#       end
#   end
# end

# http://thelucid.com/2010/01/08/sexy-validation-in-edge-rails-rails-3/
# class EmailValidator < ActiveModel::EachValidator
#   def validate_each(record, attribute, value)
#     record.errors[attribute] << (options[:message] || "is not an email") unless
#       value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
#   end
# end