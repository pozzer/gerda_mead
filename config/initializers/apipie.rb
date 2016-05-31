Apipie.configure do |config|
  config.app_name                = "Rendal"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  # config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/*.rb"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/{[!concerns/]**/*,*}.rb"
end
