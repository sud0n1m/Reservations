require 'faker'

namespace :db do
  
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    @admin = User.create!( :email => "colin@example.com",
                  :password => "foobar",
                  :password_confirmation => "foobar")
    @admin.toggle!(:admin)
    @lhproperty = @admin.properties.create( :name => "The Longhouse", :subdomain => "thelonghouse")
    
    @lhproperty.reservations.create( :email => "reservation@example.com", :from_date => Time.now + 25.days, :to_date => Time.now + 30.days)
    
    
    40.times do |n|
      email = Faker::Internet.email
      password = "password"
      @user = User.create(  :email => email,
                    :password => password,
                    :password_confirmation => password)
      subdomain = Faker::Internet.domain_word
      name = subdomain
      @property = @user.properties.create!( :name => name, :subdomain => subdomain )
      30.times do |r|
        resemail = Faker::Internet.email
        @property.reservations.create(  :email => resemail, 
                                        :from_date => Time.now + (5*r).days, 
                                        :to_date => Time.now + (5*r+2).days)
      end
    end
  end
end