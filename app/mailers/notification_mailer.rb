class NotificationMailer < ApplicationMailer
  
  default from: "kaku.takanori.1026@gmail.com"
  
  def complete_mail(user, order)
    @user = user
    @order = order
    mail(
      from: @user.email,
      to: @user.email,
      subject: '新着情報'
    )
  end
end
