source "http://rubygems.org"

gem "rails", "3.0.7"
gem "haml"
gem "authlogic"
gem "meta_search"
gem "fastercsv", "1.5.4"
gem "will_paginate", "3.0.pre2"
gem "cancan", "1.6.2"
gem "acts-as-taggable-on", "2.0.6"
gem "pg"
gem "heroku"

group :test do
  gem "test-unit"
  gem "rspec-rails"
  gem "rspec"
  gem "pickle"
  gem "factory_girl_rails"
  gem "launchy"
  gem "cucumber-rails"
end

group :test, :development do
  gem "sqlite3-ruby"
  gem "awesome_print", :require => "ap"
  platforms :ruby_18 do
    gem "ruby-debug"
  end
  platforms :ruby_19 do
    gem "ruby-debug19"
  end
end