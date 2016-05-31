source 'https://rubygems.org'

ruby "2.3.0"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
gem 'rails-i18n', '~> 4.0.0' # For 4.0.x
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use LESS for stylesheets
gem 'less-rails', '2.7.1' # github: "metaskills/less-rails"
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'rails_12factor', group: :production
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "responders"

gem 'haml', '~> 4.0.7'
gem 'haml-rails'
gem 'audited-activerecord', '~> 4.2'
gem 'breadcrumbs_on_rails', '2.3.1'

gem 'simple_form'
gem 'kaminari'
gem 'ransack', '~> 1.6.5'
gem 'squeel', '~> 1.2'

gem 'thin'
gem 'sinatra', :require => nil

gem "validate_url"

gem 'apipie-rails', '0.3.5'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  gem 'git_remote_branch',         '0.3.8'
  gem 'hub',                       '1.12.4'
  gem "simplecov",                 '0.10.0' # gem 'rcov'
  gem 'fuubar',                    '2.0.0'

  gem 'pry',                       '0.10.3'
  gem 'pry-nav',                   '0.2.4'
  gem 'pry-doc',                   '0.8.0'

  gem 'vcr',                       '3.0.1', require: false
  gem 'webmock',                   '1.22.6', require: false

  # Geração de cpf/cnpj
  gem 'rspec-rails',               '3.4.0'
  gem 'rspec-activejob',           '~> 0.6.1', require: false
  gem 'factory_girl_rails',        '4.5.0'
  gem 'database_cleaner',          '1.5.1'
  gem 'resque_spec',               '0.17.0'
  gem 'rspec-collection_matchers', '1.1.2'
  gem 'shoulda-matchers',          '3.0.1', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

