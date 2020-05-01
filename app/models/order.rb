class Order < ApplicationRecord
  belongs_to :user
  mount_uploader :image_1, ImagesUploader
  mount_uploader :image_2, ImagesUploader
  mount_uploader :image_3, ImagesUploader
  
  before_save :content_slim
  
  validates :patient_name, presence: true
  validates :sex,            presence: true
  validates :note,           presence: true, length: { maximum: 100 }
  validates :crown ,         presence: true
  validates :reception_date, presence: true
  
  validate :content_is_invalid_without_content_other
  validate :content_other_is_invalid_without_other_text
  validate :other_text_is_invalid_without_content_other
  validate :first_try_and_complete_day_is_blank
  validate :first_try_and_complete_day_presence
  validate :first_try_is_late_second_try_and_complete_day
  validate :second_try_is_late_complete_day
  
  enum color: { a1: 0, a2: 1, a3: 2, a35: 3, a4: 4, photo: 5 }
  
  def content_is_invalid_without_content_other
    if (content.blank? && content_other.blank? && other_text.blank?)
      errors.add(:content, "にレ点チェックを入れてください。")
    end
  end
  
  def content_other_is_invalid_without_other_text
    errors.add(:other_text, "に記入してください。") if content_other.present? && other_text.blank?
  end
  
  def other_text_is_invalid_without_content_other
    errors.add(:content_other, "にレ点チェックを入れてください。") if content_other.blank? && other_text.present?
  end
  
  def first_try_and_complete_day_is_blank
    if first_try.blank? && second_try.blank? && complete_day.blank?
      errors.add( :first_try, " または 完成日 に日付を入れてください。")
    end
  end
  
  def first_try_and_complete_day_presence
    if first_try.present? && complete_day.present?
      errors.add( :first_try, " または 完成日 一つに日付を入れてください。")
    end
  end
  
  def first_try_is_late_second_try_and_complete_day
    if first_try.present? && (second_try.present? || complete_day.present?)
      errors.add( :first_try, " より早い時間の入力は無効です") if first_try > (second_try || complete_day) 
    end
  end
  
  def second_try_is_late_complete_day
    if second_try.present? && complete_day.present?
      errors.add( :second_try, " より早い時間の入力は無効です") if second_try > complete_day
    end
  end
  
  def content_slim
    self.content.gsub!(/[\[\]\"]/, "").gsub!(" ","") if attribute_present?("content")
  end
end
