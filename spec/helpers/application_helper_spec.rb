require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe ".class_for_callout" do
    it "should return success if tag is notice" do
      expect(class_for_callout("notice")).to eq("success")
    end

    it "should return success if tag is success" do
      expect(class_for_callout("success")).to eq("success")
    end

    it "should return success if tag is error" do
      expect(class_for_callout("error")).to eq("danger")
    end

    it "should return success if tag is anything" do
      expect(class_for_callout("tag")).to eq("warning")
    end
  end

  describe ".link_to_with_icon" do
    it "should return tag <a> with icon inside" do
      expect(link_to_with_icon(["Name","fa fa-icon"], "http://www.example.com")).to eq("<a href=\"http://www.example.com\"><i class=\"fa fa-icon\"></i>Name</a>")
    end
  end

  describe ".get_header_title" do
    it "should return model related with controller" do
      allow(controller).to receive(:controller_name).and_return("systems")
      expect(get_header_title).to eq "Sistema"
    end

    it "should return controller name if no model was found" do
      allow(controller).to receive(:controller_name).and_return("other_systems")
      expect(get_header_title).to eq "Other systems"
    end
  end

end
