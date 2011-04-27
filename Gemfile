source "http://rubygems.org"

gem "rails", "2.3.11"
gem "haml", "3.0.24"
gem "authlogic", "2.1.6"
gem "searchlogic"
gem "fastercsv", "1.5.4"
gem "will_paginate", "2.3.15"
gem "cancan", "1.6.2"
gem "acts-as-taggable-on", "2.0.6"
gem "pg"

group :test do
  gem "test-unit"
  gem "rspec-rails", "1.3"
  gem "rspec", "1.3"
  gem "pickle"
  gem "factory_girl"
  gem "launchy"
  gem "cucumber-rails"
end

group :test, :development do
  platforms :ruby_18 do
    gem "ruby-debug"
  end
  platforms :ruby_19 do
    gem "ruby-debug19"
  end
end