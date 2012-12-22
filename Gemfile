source 'https://rubygems.org'

gem 'rails', '3.2.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do 
	gem 'rspec-rails'
  gem 'pg'
end

group :development do
  gem 'annotate'
  gem 'tunnlr_connector', :require => "tunnlr"
end

group :test do
	gem 'capybara'
	gem 'spork'
	gem 'factory_girl_rails'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'bootstrap-sass', git: 'https://github.com/chipjacks/bootstrap-sass'

  gem 'jquery-ui-rails'

  gem "font-awesome-sass-rails", "~> 2.0.0.0"
end

gem 'jquery-rails'

gem 'devise'

gem 'simple_form'

gem 'best_in_place'

gem 'chronic_duration'

gem 'chronic'

gem 'twilio-ruby'

group :production do
  gem 'pg'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
