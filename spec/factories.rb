Factory.define :property do |property|
  property.name       "The Longhouse"
  property.subdomain  "thelonghouse"
end

Factory.define :user do |user|
  user.email       "colin@example.com"
  user.password    "foobar"
  user.password_confirmation  "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :reservation do |reservation|
  reservation.email       "colin@example.net"
  reservation.from_date   Time.now + 5.days
  reservation.to_date     Time.now + 4.days
  reservation.property_id :property
end