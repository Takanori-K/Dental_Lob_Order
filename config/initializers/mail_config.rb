ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  port:                 587,
  address:              'smtp.gmail.com',
  domain:               'gmail.com',
  user_name:            ENV['USER_NAME'],
  password:             ENV['USER_PASSWORD'],
  authentication:       'plain',
  enable_starttls_auto: true
}
