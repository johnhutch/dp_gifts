source 'http://rubygems.org'

gem 'rails', '3.2.9'

group :assets do
gem 'sass-rails',   '~> 3.2.5'
gem 'coffee-rails', '~> 3.2.2'
gem 'uglifier', '>= 1.2.6'
end

gem 'jquery-rails', '~> 2.0.2'
gem 'mysql2'
gem 'capistrano'
gem 'json'
gem 'therubyracer' # added to avoid javascript errors on deploy

gem 'cancan', '~> 1.6.8'
gem 'devise', '~> 2.1.2'
gem 'omniauth-twitter'
gem 'omniauth-facebook'

gem 'redcarpet'
gem 'formalize-rails'
gem 'paperclip', :git => "git://github.com/thoughtbot/paperclip.git"
gem 'nested_form', :git => 'https://github.com/ryanb/nested_form.git'
gem 'rails_config'
gem 'stamp'
gem 'state_machine'

group :development, :test do
    gem 'sqlite3'
    gem 'rspec-rails'
    gem "letter_opener"
end

group :test do
    gem 'factory_girl'
    gem 'factory_girl_rails', :require => false
    gem 'capybara-webkit'
    gem 'guard-rspec'
    gem 'launchy'
    gem 'rb-fsevent' # mac-only gem for guard auto-detect. remove if on another OS
    gem 'database_cleaner'
    gem 'spork', '~> 0.9.0.rc'
    gem 'guard-spork'
end
