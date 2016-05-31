ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'rspec/active_job'
require 'vcr'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.render_views
  config.include FactoryGirl::Syntax::Methods
  config.include ActiveSupport::Testing::TimeHelpers
  config.include(RSpec::ActiveJob)

  # clean out the queue after each spec
  config.after(:each) do
    ActiveJob::Base.queue_adapter.enqueued_jobs = []
    ActiveJob::Base.queue_adapter.performed_jobs = []
  end

end
