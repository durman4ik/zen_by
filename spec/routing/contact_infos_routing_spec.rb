require "rails_helper"

RSpec.describe ContactInfosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/contact_infos").to route_to("contact_infos#index")
    end

    it "routes to #new" do
      expect(:get => "/contact_infos/new").to route_to("contact_infos#new")
    end

    it "routes to #show" do
      expect(:get => "/contact_infos/1").to route_to("contact_infos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/contact_infos/1/edit").to route_to("contact_infos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/contact_infos").to route_to("contact_infos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/contact_infos/1").to route_to("contact_infos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/contact_infos/1").to route_to("contact_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/contact_infos/1").to route_to("contact_infos#destroy", :id => "1")
    end

  end
end
