# frozen_string_literal: true

module OrderDecorator
  def order_image_1_edit
    if image_1?
      image_tag image_1.thumb.url, id: :edit_img_prev, onClick: "$('#upfile').click()"
    else
      image_tag "https://takanori-private-image.s3-ap-northeast-1.amazonaws.com/background-image/no-image.jpg", id: :edit_img_prev, onClick: "$('#upfile').click()"
    end
  end

  def order_image_2_edit
    if image_2?
      image_tag image_2.thumb.url, id: :edit_img_prev_2, onClick: "$('#upfile2').click()"
    else
      image_tag "https://takanori-private-image.s3-ap-northeast-1.amazonaws.com/background-image/no-image.jpg", id: :edit_img_prev_2, onClick: "$('#upfile2').click()"
    end
  end

  def order_image_3_edit
    if image_3?
      image_tag image_3.thumb.url, id: :edit_img_prev_3, onClick: "$('#upfile3').click()"
    else
      image_tag "https://takanori-private-image.s3-ap-northeast-1.amazonaws.com/background-image/no-image.jpg", id: :edit_img_prev_3, onClick: "$('#upfile3').click()"
    end
  end

  def order_image_1
    if image_1?
      image_tag image_1.thumb.url
    else
      image_tag "https://takanori-private-image.s3-ap-northeast-1.amazonaws.com/background-image/no-image.jpg"
    end
  end

  def order_image_2
    if image_2?
      image_tag image_2.thumb.url
    else
      image_tag "https://takanori-private-image.s3-ap-northeast-1.amazonaws.com/background-image/no-image.jpg"
    end
  end

  def order_image_3
    if image_3?
      image_tag image_3.thumb.url
    else
      image_tag "https://takanori-private-image.s3-ap-northeast-1.amazonaws.com/background-image/no-image.jpg"
    end
  end
end
