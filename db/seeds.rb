# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tags = %w[Laser Viagen Compras Estudo Transport Alimentacion Bebida]

clan = Clan.where(name: 'Clan test')
clan.destroy

clan = Clan.create!(name: 'Clan test', description: 'Clan created automatic...', status: 0)

puts "Clan created: #{clan.name}"

users = []
3.times do |u|
    User.where(name: "User_#{u}").destroy
    user = User.create!(name: "User_#{u}", email:'email@email.com', status: 0, clan: clan)
    Tag.create!(tag: tags[rand(tags.size)], user: user)
    users.push(user)
end
4.times do |month|
    12.times do |i|
        item_name = "item_#{month}_#{i}"
        item = Expense.where(name: item_name)
        item.destroy
        Expense.create!(name: item_name, description: item_name, value: 10.0 * rand(15), status: 0, date: (month -1).month.from_now, 
        tags:[tags[rand(tags.size)], tags[rand(tags.size)], tags[rand(tags.size)]], clan: clan, user: users[rand(users.size)])
    end
end

puts '*' * 60,'Created data in db', '*' * 60