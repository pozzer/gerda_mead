require 'rails_helper'

class ResponsesController < Api::ApiController; end

RSpec.describe ResponsesController, type: :controller do

  controller do
    api :GET, '/', 'Index de teste'
    def index
      rise StandardError
    end

    api :POST, '/', 'POST de teste'
    def create
      rise StandardError
    end

    api :put, '/', 'PUT de teste'
    def update
      rise StandardError
    end
  end

  before do
    set_token
  end

  context "rescue from StandardError" do
    describe "#internal_error" do
      it "render internal server error" do
        expected = {"error" => "Internal Server Error"}

        post :create

        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected)
        expect(response.status).to eq(500)
      end
    end

    describe "#internal_error_log" do
      it "create post receive error log" do
        expect {
          post :create
        }.to change(Log.post_received.error, :count).by(1)
      end

      it "update put receive error log" do
        expect {
          put :update, {id: 1}
        }.to change(Log.put_received.error, :count).by(1)
      end

      it "create general error log" do
        expect {
          get :index
        }.to change(Log.general.error, :count).by(1)
      end
    end
  end
end
