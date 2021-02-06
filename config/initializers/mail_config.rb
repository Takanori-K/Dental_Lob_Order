ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  port:                 587,
  address:              'smtp.gmail.com',
  domain:               'gmail.com',
  user_name:            'kaku.takanori.1026@gmail.com',
  password:             'lfvgsddzocaprexe',
  authentication:       'plain',
  enable_starttls_auto: true
}
