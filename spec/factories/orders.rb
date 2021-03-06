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

  factory :order2, class: Order do
    association :user
    patient_name            { "テスト" }
    sex                     { "男" }
    note                    { "上顎１番" }
    content                 { "AC" }
    crown                   { "単冠" }
    first_try               { DateTime.current + 2.day }
    reception_date          { Date.current.to_s }
    complete_day            { DateTime.current + 10.day }
  end
end
