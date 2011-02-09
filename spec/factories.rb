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
  reservation.from_date   Time.now + 20.weeks
  reservation.to_date     Time.now + 21.weeks
  reservation.property_id :property
end