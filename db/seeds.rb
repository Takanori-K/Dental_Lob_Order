# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "T-セラミックス",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
             
User.create!(name: "テスト歯科医院",
             email: "sample2@email.com",
             password: "password",
             password_confirmation: "password")
             
User.create!(name: "プログラミング歯科医院",
             email: "sample3@email.com",
             password: "password",
             password_confirmation: "password")
             
User.create!(name: "Ruby歯科医院",
             email: "sample4@email.com",
             password: "password",
             password_confirmation: "password")
             
User.create!(name: "Java歯科医院",
             email: "sample5@email.com",
             password: "password",
             password_confirmation: "password")
             
User.create!(name: "PHP歯科医院",
             email: "sample6@email.com",
             password: "password",
             password_confirmation: "password")
             
User.create!(name: "C+歯科医院",
             email: "sample7@email.com",
             password: "password",
             password_confirmation: "password")
             
User.create!(name: "Python歯科医院",
             email: "sample8@email.com",
             password: "password",
             password_confirmation: "password")
             
User.create!(name: "Swift歯科医院",
             email: "sampl9e@email.com",
             password: "password",
             password_confirmation: "password")