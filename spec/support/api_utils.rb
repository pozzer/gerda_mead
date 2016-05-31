def set_token(system=nil, account=nil)
  @current_account = account || FactoryGirl.create(:account)
  @current_system = system || FactoryGirl.create(:system, account: @current_account)

  @request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(@current_system.token)
  @request.env["CONTENT_TYPE"] = "application/json"
end
