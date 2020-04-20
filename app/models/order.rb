class Order < ApplicationRecord
  belongs_to :user
  
  validates :patient_name, presence: true
  validates :sex, presence: true
  validates :note, presence: true, length: { maximum: 100 }
  
  enum color: { a1: 0, a2: 1, a3: 2, a35: 3, a4: 4, photo: 5 }
end
