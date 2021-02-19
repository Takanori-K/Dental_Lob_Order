# frozen_string_literal: true

module UserDecorator

  def user_image
    if image?
      image_tag image.thumb.url, id: :img_prev, onClick:"$('#user_img').click()"
    else
      image_tag "https://takanori-private-image.s3-ap-northeast-1.amazonaws.com/background-image/facility_default.png", id: :img_prev, onClick:"$('#user_img').click()"
    end
  end
  
end
