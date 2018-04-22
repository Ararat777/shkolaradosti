# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Income.delete_all
Branch.delete_all
branch = Branch.create(:title => "Filial nomer 1")
branch_2 = Branch.create(:title => "Filial nomer 2")

CashBox.delete_all
branch.create_cash_box(:cash => 0)
branch_2.create_cash_box(:cash => 0)

User.delete_all
branch.create_user(:email => "admin@admin.com", :password => "123456")
branch_2.create_user(:email => "vasya@admin.com", :password => "123456")

Client.delete_all
branch.clients.create(:name => "Вася Пупкин", :age => 4)
branch.clients.create(:name => "Петя Жопкин", :age => 5)
branch.clients.create(:name => "Маша Машкина", :age => 3)

Service.delete_all
branch.services.create(:title => "Детский сад", :price => 1000)
branch.services.create(:title => "Питание", :price => 500)
branch.services.create(:title => "Физра", :price => 100)