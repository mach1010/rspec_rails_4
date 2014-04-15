require 'rubygems'
require 'spork'
require 'database_cleaner'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  RSpec.configure do |config|
    config.use_transactional_fixtures = false
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.include FactoryGirl::Syntax::Methods

    config.after(:each) do
      DatabaseCleaner.clean
    end

    # Include Factory Girl syntax to simplify calls to factories
    config.include FactoryGirl::Syntax::Methods
  end
end

Spork.each_run do
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  FactoryGirl.reload
  include LoginMacros
end
