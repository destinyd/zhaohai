require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'http://ruby.taobao.org'
#source 'https://rubygems.org'
gem 'rails', '3.2.12'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem 'jquery-rails'
gem "mongoid", ">= 3.1.2"
gem "rspec-rails", ">= 2.11.4", :group => [:development, :test]
gem "rspec-cells", :group => [:development, :test]
gem "capybara", ">= 2.0.1", :group => :test
gem "database_cleaner", ">= 0.9.1", :group => :test
gem "mongoid-rspec", ">= 1.5.5", :group => :test
gem "email_spec", ">= 1.4.0", :group => :test
gem "factory_girl_rails", ">= 4.1.0", :group => [:development, :test]
gem "bootstrap-sass", ">= 2.2.2.0"
gem "devise", ">= 2.1.2"
gem "cancan", ">= 1.6.8"
gem "rolify", ">= 3.2.0"
gem "simple_form", ">= 2.0.4"
gem "quiet_assets", ">= 1.0.1", :group => :development
gem "figaro", ">= 0.5.0"
gem "better_errors", ">= 0.3.2", :group => :development
gem "binding_of_caller", ">= 0.6.8", :group => :development

case HOST_OS
when /darwin/i
  gem 'rb-fsevent', :group => :development
  gem 'growl', :group => :development
  gem 'guard-pow', :group => :development
when /linux/i
  gem 'libnotify', :group => :development
  gem 'rb-inotify', :group => :development
  gem "unicorn", ">= 4.3.1", :group => :production
  group :test do
    gem 'guard-spork'#, '0.3.2'
    gem 'spork'#, '0.9.0'
  end
when /mswin|windows/i
  gem 'rb-fchange', :group => :development
  gem 'win32console', :group => :development
  gem 'rb-notifu', :group => :development
end

gem 'inherited_resources'
gem 'doorkeeper', '~> 0.6.2'
gem 'meta-tags', :require => 'meta_tags',git: 'git://github.com/destinyd/meta-tags.git'
gem 'mongoid_taggable_on'
gem 'random_data'
gem 'kaminari'
#gem 'bootstrap-kaminari-views'
gem 'kaminari-bootstrap'
gem "cells"
#gem 'resque'
#gem 'delayed_job_mongoid'
#gem 'daemons'
gem "symbolize", :require => "symbolize/mongoid"
group :development do
  gem 'guard-rspec'#, '0.5.5',
end
#gem 'debugger', git: 'git://github.com/cldwalker/debugger.git',group: [:development, :test]
gem 'jquery-ui-rails'

#ajax carrierwave https://github.com/huobazi/ajax-upload-with-carrierwave-mongoid
gem 'carrierwave'#, '0.6.2'
gem 'carrierwave-mongoid', :git => 'git://github.com/jnicklas/carrierwave-mongoid.git'#, :branch => 'mongoid-3.0' 
gem 'mini_magick'#, '3.4'
#gem 'rack-raw-upload'#, '1.1.0'
gem 'simple_form_fancy_uploads'
#gem 'chosen-rails'
gem "select2-rails"
