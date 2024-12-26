source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.6"

gem "rails", "~> 7.0.8", ">= 7.0.8.6"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "active_model_serializers", "~> 0.10.14"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "tty-spinner", "~> 0.9.3"
gem "bcrypt"
gem "jwt"
gem 'state_machines'
gem 'state_machines-activerecord'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 7.0.0'
  gem 'shoulda-matchers'
end

group :development do
  gem "faker", "~> 3.4"
end
