source 'http://rubygems.org'

gem 'rails', '3.2.2'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'mysql2'
gem 'capistrano'
gem 'json'

gem 'cancan'
gem 'devise'

gem 'redcarpet'
gem 'formalize-rails'
gem 'paperclip', :git => "git://github.com/thoughtbot/paperclip.git"

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails' 
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'rb-fsevent' # mac-only gem for guard auto-detect. remove if on another OS
  gem 'database_cleaner'
end
