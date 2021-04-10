class NotificationMailer < ApplicationMailer

  default from: ENV['USER_NAME']

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

  def complete_order_mail(user, order, admin)
    @user = user
    @order = order
    @admin = admin
    mail(
      from: @admin.email,
      to: @user.email,
      subject: '技工物完成'
    )
  end
end
