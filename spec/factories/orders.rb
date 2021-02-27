FactoryBot.define do
  factory :order do
    association :user
    sequence(:patient_name) { |n| "patient#{n}" }
    sex                     { "男" }
    sequence(:note)         { |n| "note#{n}" }
    content                 { "オールセラミック" }
    crown                   { "連結" }
    metal                   { "クインテス" }
    first_try               { "2021-03-01" }
    reception_date          { Date.current.to_s }
    complete_day            { "2021-03-10" }
  end
end
