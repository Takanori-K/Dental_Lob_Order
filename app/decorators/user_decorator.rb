# frozen_string_literal: true

module UserDecorator
  def user_image_edit
    if image?
      image_tag image.thumb.url, id: :img_prev, onClick: "$('#user_img').click()"
    else
      image_tag "/default.png", id: :img_prev, onClick: "$('#user_img').click()"
    end
  end

  def user_image
    if image?
      image_tag image.thumb.url
    else
      image_tag "/default.png"
    end
  end
end
