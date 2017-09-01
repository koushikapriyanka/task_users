# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do |user_id|
	User.create!(:email=> "user_#{user_id}@gmail.com", :password => "pwd@123456#{user_id}",:role => 1)
end
2.times do |user_id|
	User.create(:email=> "user#{user_id}@gmail.com", :password => "pwd@12345#{user_id}",:role => 2)
end
100.times do 
	Task.create(:name=>"Complete #{Faker::Educator.course}",:status=>Random.new.rand(1..4), :user_id => Random.new.rand(1..49))
end

