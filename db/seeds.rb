# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

["Art", "Sports", "Technology", "Food"].each do |cat|
  c = Category.new(name: cat)
  c.save
end

["Ruby", "Rails", "Javascript", "HTML", "CSS", "Git", "Github", "SQL", "jQuery",
"React.js", "APIs"].each do |tag|
  Tag.create(name: tag)
end

User.create(first_name: "admin", email: "admin@email.com", password: "admin", admin: true)
User.create(first_name: "user", email: "user@email.com", password: "user", admin: false)
