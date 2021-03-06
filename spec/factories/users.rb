FactoryBot.define do
  factory :user do
    sequence(:name)       { |n| "sample#{n}" }
    sequence(:email)      { |n| "TEST#{n}@example.com" }
    password              { "password" }
    password_confirmation { "password" }
  end

  factory :admin, class: User do
    name                  { "管理者" }
    email                 { "admin1@email.com" }
    password              { "password" }
    password_confirmation { "password" }
    admin                 { "true" }
  end
end
