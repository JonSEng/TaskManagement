source 'https://rubygems.org'

# Eventmachine
gem 'eventmachine', github:"eventmachine/eventmachine"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Used for haml
gem 'haml-rails'
gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# FontAwesome
gem 'font-awesome-sass'

# Flat UI
gem "twitter-bootstrap-rails"
gem 'flatui-rails'

# Compress Javascript assets, use Coffeescript when possible, add JQuery
gem 'jquery-rails'
gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
gem 'jquery-ui-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

# Google auth
gem 'devise'
gem 'omniauth-google-oauth2'
gem 'protected_attributes'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Turbolinks speed up following links. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment - allows for parallel connections (like you'd expect on websites)
# gem 'capistrano', group: :development

# Set Backend Database
group :development,:test do
	# Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.0'
end
group :production do
	gem 'pg'
end

# Use debugger
gem 'byebug'

#Added to try to get css working on heroku http://stackoverflow.com/questions/16271696/cant-get-css-working-on-heroku-using-rails-4-with-bootstrap-saas-gem
group :production do
	gem 'rails_12factor'
end

######################################################################
#Extra gems added
######################################################################
gem 'seed_dump'
gem 'thin'
gem 'twilio-ruby'
gem 'xpath'
