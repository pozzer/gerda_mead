require File.expand_path('../boot', __FILE__)

require "net/http"
require "uri"

require 'rails/all'

ENV['RANSACK_FORM_BUILDER'] ||= '::SimpleForm::FormBuilder'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rendal
  VERSION = "0.0.1"

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Brasilia'

     config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

    # Rails 5

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.available_locales = :'pt-BR'
    config.i18n.default_locale = :'pt-BR'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml')]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # The Active Job adapter must be set to :sidekiq or it will simply use the default
    #config.active_job.queue_adapter = :sidekiq

    config.autoload_paths += %W(
      #{Rails.root}/app/controllers/api/concerns
    )

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework  :rspec, fixture: false
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
      g.scaffold_controller :responders_controller
    end
  end


end


# to solve less-rails problem
# https://github.com/metaskills/less-rails/issues/103
# Rendal::Application.assets = Sprockets::Railtie.build_environment(Rendal::Application, true)
