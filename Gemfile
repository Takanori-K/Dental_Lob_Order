source 'https://rubygems.org'

gem 'rails', '~> 5.1.6'
gem 'rails-i18n'
gem 'enum_help'
gem 'bootstrap-sass'
gem 'bcrypt'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-line'
gem "bulma-rails"
gem 'will_paginate'
gem 'will_paginate-bulma'
gem 'simple_calendar', '~> 2.0'
gem 'bootstrap-social-rails'
gem 'font-awesome-rails'
gem 'carrierwave'
gem 'fog-aws'
gem 'mini_magick'
gem 'active_decorator'
gem 'dotenv-rails'
gem 'puma',         '~> 3.7'
gem 'sass-rails',   '~> 5.0'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks',   '~> 5'
gem 'jbuilder',     '~> 2.5'
gem 'wkhtmltopdf-binary'
gem 'wicked_pdf'

group :development, :test do
  # gem 'sqlite3'
  gem 'mysql2'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :production do
  gem 'pg', '0.20.0'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
# Mac環境でもこのままでOKです
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
