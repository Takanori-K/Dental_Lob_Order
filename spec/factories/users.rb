FactoryBot.define do
  factory :user do
    sequence(:name)       { |n| "sample#{n}" }
    sequence(:email)      { |n| "TEST#{n}@example.com" }
    password              { "password" }
    password_confirmation { "password" }
    admin                 { "true" }
  end
end
