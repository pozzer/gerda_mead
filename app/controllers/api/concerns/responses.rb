module Responses
  extend ActiveSupport::Concern

  private
    def test_params_json
      raise Api::NotAcceptableParameters unless request.env["CONTENT_TYPE"] =~ /application\/json/ or params['format'] == 'json'
    end

    def not_acceptable
      render :json => {:error => 'Not Acceptable'}, :status => 406
    end

    def unprocessable_entity(message = "Unprocessable Entity")
      render :json => {:error => message}, :status => 422
    end

    def internal_error
      render :json => {:error => "Internal Server Error"}, :status => 500
    end

    def internal_error_log(exception)
      if params[:action] == "create"
        Log.post_received_error(@current_account.id, @current_system.id, exception.message, exception)
      elsif params[:action] == "update"
        Log.put_received_error(@current_account.id, @current_system.id, exception.message, exception)
      else
        Log.general_error(@current_account.id, @current_system.id, exception.message, exception)
      end

      Rollbar.log('error', exception)
    end
end
