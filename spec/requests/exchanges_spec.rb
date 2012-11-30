require 'spec_helper'

describe "Exchanges" do
  let(:admin) {FactoryGirl.create(:admin)}

  describe "GET /exchanges" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get exchanges_path
      response.status.should be(200)
    end
  end

  describe "POST /exchange" do
    it "lets an admin create a new exchange" do
      login(admin)
      visit admin_path

      click_link "Create a new exchange"
      fill_in "Name", :with => "The new DP exchange"
      fill_in "Description", :with => "This is a new exchange for double prime"
      fill_in "Summary", :with => "The summary goes here."
      click_button "Create Exchange"
      page.should have_content ("successfully created")
      page.should have_content ("The new DP exchange")
    end
  end
end
