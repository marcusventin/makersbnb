# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '3.0.0'
gem 'pg'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'bootstrap', '~> 5.0.2'
gem 'sinatra-flash'
gem 'bcrypt'

group :test do
  gem 'capybara'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'puma'
  gem 'thin'
  gem 'falcon'
  gem 'webrick'
  gem 'launchy'
end

group :development, :test do
  gem 'rubocop', '1.20'
end
