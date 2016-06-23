class Api::NotAcceptableParameters < RuntimeError; end

class Api::ApiController < ApplicationController
  include Authentication, Responses

  skip_before_action :verify_authenticity_token

  rescue_from StandardError do |exception|
    internal_error_log(exception)
    internal_error
  end

  rescue_from Api::NotAcceptableParameters, :with => :not_acceptable

  respond_to :json

  before_action :test_params_json, :authenticate


end
