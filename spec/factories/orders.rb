FactoryBot.define do
  factory :order do
    association :user
    sequence(:patient_name) { |n| "patient#{n}" }
    sex                     { "男" }
    sequence(:note)         { |n| "note#{n}" }
    content                 { "AC" }
    crown                   { "連結" }
    metal                   { "クインテス" }
    first_try               { DateTime.current + 2.day }
    reception_date          { Date.current.to_s }
    complete_day            { DateTime.current + 10.day }
  end
end
