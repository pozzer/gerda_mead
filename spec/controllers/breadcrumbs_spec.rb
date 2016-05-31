require 'rails_helper'

class BreadCrumb < ActiveRecord::Base; end
class BreadCrumbsController < AppController; end

RSpec.describe BreadCrumbsController, type: :controller do
  let(:account) { FactoryGirl.create(:account) }

  describe "#get_model" do
    it "return the controller name constantized" do
      expect(controller.send("get_model")).to eq(BreadCrumb)
    end
  end

  describe "#path_to_index" do
    it "return the controller path with account" do
      controller.params[:account_id] = account.id
      expect(controller.send("path_to_index")).to eq("/accounts/#{account.id}/bread_crumbs")
    end
  end
end
