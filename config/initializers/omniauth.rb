Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['537283740252362'], ENV['22f3fe35d84730890a6af9bfb9887a76']
end