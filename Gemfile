source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'devise'
gem 'dotenv-rails'
gem 'pg'
gem 'base58'
gem 'httparty'
gem 'aasm'

# frontend
gem 'bootstrap-validator-rails'
gem 'bootstrap_form'
gem 'bootstrap3-datetimepicker-rails'
gem 'momentjs-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'pry-byebug'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'rails', '~> 5.2.4.2'
gem 'sqlite3'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem "paperclip", "~> 5.0.0"
gem "twilio-ruby"
gem 'time_difference'


group :development, :test do
  gem 'byebug', platform: :mri
end

group :test do
  gem 'rspec-rails', '~> 3.5'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'capybara'
  gem 'selenium-webdriver','2.53.4'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'pdf-reader'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano-rails-console',   require: false
  gem 'capistrano-rails-collection'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
