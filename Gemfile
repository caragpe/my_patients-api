# frozen_string_literal: true

source 'https://rubygems.org'

gem 'faker'
gem 'interactor', '~> 3.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.0'
gem 'sqlite3'

group :development, :test do
  gem 'awesome_print', '~> 1.8'
  gem 'pry-byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'rubocop', '~> 0.55.0'
end

group :test do
  gem 'factory_bot_rails', '~> 4.0'
  gem 'mocha'
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'shoulda', '~> 3.5'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end
