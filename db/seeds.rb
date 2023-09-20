# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Subscription.destroy_all
Tea.destroy_all
Customer.destroy_all

FactoryBot.create_list(:customer, 10)
FactoryBot.create_list(:tea, 10)
FactoryBot.create_list(:subscription, 10)