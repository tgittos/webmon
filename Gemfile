source 'https://rubygems.org'

# Use JRuby 9.0.5.0
ruby '2.2.3', :engine => 'jruby', :engine_version => '9.0.5.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# still need to use special Windows build of nokogiri
gem 'nokogiri'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'rspec-rails', '~> 3.2.1'
  gem 'pry'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  #gem 'web-console', '~> 2.0'
end

group :test do
  gem 'capybara', '~> 2.4'
  gem 'factory_girl_rails', '~> 4.5'
  gem 'fakeweb', '~> 1.3.0'
  gem 'timecop', '~> 0.8.0'
end

group :production do
  gem 'rails_12factor'
end

# Use Postgres as database
gem 'activerecord-jdbcpostgresql-adapter'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Bootstrap cause I can't design
gem 'bootstrap-sass', '~> 3.3'
gem 'font-awesome-rails', '~> 4.3'
gem 'simple_form', '~> 3.1.0'

# Scheduling
gem 'rufus-scheduler', '~> 3.1.5'

# Email alerts
#gem 'mailgun-ruby', '~> 1.0.2', require: 'mailgun'
gem 'mailgun_rails'

# Onboarding
gem 'hopscotch-rails'
gem 'js_cookie_rails'

gem 'puma'
