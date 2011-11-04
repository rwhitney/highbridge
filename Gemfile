source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'execjs', '~> 1.2'
gem 'therubyracer', '~> 0.9'
gem 'rake', '0.9.2.2'
gem 'devise', '~> 1.4'

# we no longer use sqlite3 in any environments
gem 'mysql2', '~> 0.3'
gem 'mysql', '~> 2.8'

group :test do
  gem "webrat"
end

# testing infrastructure
group :test, :development do
  gem "rspec", '~> 2.7'
  gem "rspec-rails", '~> 2.7'
  gem "factory_girl_rails", '~> 1.3'
end

# Gems used only for assets (e.g. assets:precompile) and not required
# in production environments by default.
group :assets do
  gem 'ansi', '~> 1.3'
  gem 'highline', '~> 1.6'
  gem 'net-ssh', '~> 2.2'
  gem 'net-scp', '~> 1.0'
  gem 'net-sftp', '~> 2.0'
  gem 'net-ssh-gateway', '~> 1.1'
  gem 'coffee-script-source', '~> 1.1'
  gem 'coffee-script', '~> 2.2'
  gem 'libv8', '~> 3.3'
  gem 'sass', '~> 3.1.10'
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '~> 1.0.16'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Deploy with Capistrano
gem 'capistrano', '~> 2.9'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8', :require => false
end
