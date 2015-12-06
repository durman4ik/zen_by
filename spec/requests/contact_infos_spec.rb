require 'rails_helper'

RSpec.describe "ContactInfos", type: :request do
  describe "GET /contact_infos" do
    it "works! (now write some real specs)" do
      get contact_infos_path
      expect(response).to have_http_status(200)
    end
  end
end
