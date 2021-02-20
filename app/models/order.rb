class Order < ApplicationRecord
  belongs_to :user
  attr_accessor :check_delete

  mount_uploader :image_1, ImagesUploader
  mount_uploader :image_2, ImagesUploader
  mount_uploader :image_3, ImagesUploader

  validates :patient_name,   presence: true
  validates :sex,            presence: true
  validates :note,           presence: true, length: { maximum: 100 }
  validates :crown,          presence: true
  validates :reception_date, presence: true

  validate :content_is_invalid_without_content_other
  validate :content_other_is_invalid_without_other_text
  validate :other_text_is_invalid_without_content_other
  validate :first_try_and_complete_day_is_blank
  validate :first_try_is_late_second_try_and_complete_day
  validate :second_try_is_late_complete_day
  validate :first_try_is_late_date_current
  validate :second_try_is_late_date_current
  validate :complete_day_is_late_date_current

  enum color: { a1: 0, a2: 1, a3: 2, a35: 3, a4: 4, photo: 5 }

  def content_is_invalid_without_content_other
    return unless (content.blank? && content_other == "false" && other_text.blank?)

    errors.add(:content, "にレ点チェックを入れてください。")
  end

  def content_other_is_invalid_without_other_text
    errors.add(:other_text, "に記入してください。") if content_other == "その他" && other_text.blank?
  end

  def other_text_is_invalid_without_content_other
    errors.add(:content_other, "にレ点チェックを入れてください。") if (content_other.blank? || content_other == "false") && other_text.present?
  end

  def first_try_and_complete_day_is_blank
    return unless first_try.blank? && second_try.blank? && complete_day.blank?

    errors.add(:first_try, " または 完成日 に日付を入れてください。")
  end

  def first_try_is_late_second_try_and_complete_day
    return unless first_try.present? && (second_try.present? || complete_day.present?)

    errors.add(:first_try, " より早い時間の入力は無効です") if first_try > (second_try || complete_day)
  end

  def second_try_is_late_complete_day
    return unless second_try.present? && complete_day.present?

    errors.add(:second_try, " より早い時間の入力は無効です") if second_try > complete_day
  end

  def first_try_is_late_date_current
    return unless first_try.present?

    errors.add(:first_try, " は今日より早い時間の入力は無効です") if first_try < Date.current
  end

  def second_try_is_late_date_current
    return unless second_try.present?

    errors.add(:second_try, " は今日より早い時間の入力は無効です") if second_try < Date.current
  end

  def complete_day_is_late_date_current
    return unless complete_day.present?

    errors.add(:complete_day, " は今日より早い時間の入力は無効です") if complete_day < Date.current
  end

  def self.search(search)
    return Order.all unless search

    Order.where(['content LIKE ?', "%#{search}%"])
  end
end
