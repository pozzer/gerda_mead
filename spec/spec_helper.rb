if ENV['coverage'] == 'on'
  require 'simplecov'
  SimpleCov.start 'rails' do
    minimum_coverage 100
  end
end

# save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLE_ARTIFACTS']
  require 'simplecov'
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], "coverage")
  SimpleCov.coverage_dir(dir)
  SimpleCov.start 'rails'
end

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
end
