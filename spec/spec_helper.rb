# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spork'


# Loading more in this block will cause your tests to run faster. However,
# if you change any configuration or code from libraries loaded here, you'll
# need to restart spork for it take effect.
Spork.prefork do

  ENV["RAILS_ENV"] ||= 'test'

  require 'rubygems'
  require File.expand_path("../../config/application", __FILE__)
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'machinist/active_record'
  require 'sham'
  require 'faker'

  RSpec.configure do |config|
    config.mock_framework = :rr

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    config.global_fixtures = :locations

    # needed for machinist ... moved from prefork
    config.before(:all)    { Sham.reset(:before_all)  }
    config.before(:each)   { Sham.reset(:before_each) }
   end

end

# This code will be run each time you run your specs.
Spork.each_run do

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
end

# rename satisfy to rr_satisfy
def rr_satisfy
  RR::WildcardMatchers::Satisfy.new(lambda {|arg| yield(arg)})
end
