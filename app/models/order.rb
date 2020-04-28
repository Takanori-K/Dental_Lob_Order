class Order < ApplicationRecord
  belongs_to :user
  mount_uploader :image_1, ImageUploader
  mount_uploader :image_2, ImageUploader
  mount_uploader :image_3, ImageUploader
  validates :patient_name, presence: true
  validates :sex,            presence: true
  validates :note,           presence: true, length: { maximum: 100 }
  validates :crown ,         presence: true
  validates :reception_date, presence: true
  
  validate :content_is_invalid_without_content_other
  validate :content_other_is_invalid_without_other_text
  validate :other_text_is_invalid_without_content_other
  
  enum color: { a1: 0, a2: 1, a3: 2, a35: 3, a4: 4, photo: 5 }
  
  def content_is_invalid_without_content_other
    if content.blank? && (other_text.present? || content_other.present?) || content.blank? && (other_text.blank? || content_other.present?)
      errors.add(:content, "にレ点チェックを入れてください。")
    end
  end
  
  def content_other_is_invalid_without_other_text
    errors.add(:other_text, "に記入してください。") if content_other.present? && other_text.blank?
  end
  
  def other_text_is_invalid_without_content_other
   errors.add(:content_other, "にレ点チェックを入れてください。") if content_other.blank? && other_text.present?
  end
end
