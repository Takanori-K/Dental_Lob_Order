# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "テストデンタルラボラトリー",
             email: "kaku.takanori.1026@gmail.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
             
User.create!(name: "テスト歯科医院",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password")
             