class Order < ApplicationRecord
  belongs_to :user
  mount_uploader :image_1, ImageUploader
  mount_uploader :image_2, ImageUploader
  mount_uploader :image_3, ImageUploader
  validates :patient_name, presence: true
  validates :sex,            presence: true
  validates :note,           presence: true, length: { maximum: 100 }
  validates :content,        presence: true
  validates :crown ,         presence: true
  validates :reception_date, presence: true
  enum color: { a1: 0, a2: 1, a3: 2, a35: 3, a4: 4, photo: 5 }
end
