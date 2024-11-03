# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', require: false
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8', '>= 7.0.8.6'
gem 'sqlite3', '~> 1.4'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'rubocop'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end
