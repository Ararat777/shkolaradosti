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
branch.users.create(:email => "admin@admin.com", :password => "123456")
branch_2.users.create(:email => "vasya@admin.com", :password => "123456")


Service.delete_all
branch.services.create(:title => "Детский сад", :price => 1000)
branch.services.create(:title => "Питание", :price => 50,:countable => true)
branch.services.create(:title => "Физра", :price => 100)

Role.delete_all
Role.create(:id =>1,:title => "Администратор")
Role.create(:id =>2,:title => "Бухгалтер")
Role.create(:id =>3,:title => "Завхоз")



Month.delete_all
year = Date.today.year
months = ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь']
months.each_with_index do |title,number|
  Month.create(:title => title,:number => number + 1,:year => year)
end
