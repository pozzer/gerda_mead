require 'rails_helper'

class SomeController < Api::ApiController; end

RSpec.describe SomeController, type: :controller do

  controller do
    api :GET, '/', 'Index de teste'
    def index
      render :json => {:success => 'Yaaay!'}, status: 200
    end
  end

  context "validates content type" do
    it "return error with status 406 if content type isn't json" do
      expected = {"error" => "Not Acceptable"}
      get :index
      response_body = JSON.parse(response.body)

      expect(response_body).to eq(expected)
      expect(response.status).to eq(406)
    end
  end

  context "auhtentication" do
    it "return error with status 401 without token" do
      expected = {"error" => "Bad credentials"}
      get :index, format: :json
      response_body = JSON.parse(response.body)

      expect(response_body).to eq(expected)
      expect(response.status).to eq(401)
    end

    it "return succes with status 200 with valid token" do
      system = FactoryGirl.create(:system)

      expected = {"success" => "Yaaay!"}

      @request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(system.token)
      get :index, format: :json

      response_body = JSON.parse(response.body)

      expect(response_body).to eq(expected)
      expect(response.status).to eq(200)
    end
  end
end
