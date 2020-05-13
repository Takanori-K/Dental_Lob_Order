class NotificationMailer < ApplicationMailer
  
  default from: "kaku.takanori.1026@gmail.com"
  
  def complete_mail(user, order, admin)
    @user = user
    @order = order
    @admin = admin
    mail(
      from: @user.email,
      to: @admin.email,
      subject: '新着情報'
    )
  end
end
