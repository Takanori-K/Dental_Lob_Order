class Order < ApplicationRecord
  belongs_to :user
  
  validates :patient_name, presence: true
  validates :sex, presence: true
  validates :note, presence: true, length: { maximum: 100 }
end
