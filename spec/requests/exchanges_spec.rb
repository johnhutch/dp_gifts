require 'spec_helper'

describe "Exchanges" do
  let(:user) {FactoryGirl.create(:nobody)}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:exchange) {FactoryGirl.create(:exchange)}
  let(:exchange1) {FactoryGirl.create(:exchange)}
  let(:exchange2) {FactoryGirl.create(:exchange)}

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
      page.should have_content ("This gift exchange is open for signups")
    end
  end

  describe "GET /exchange/:id/trigger_matchups" do
    it "switches the exchange state to matched" do
    end
  end

  describe "GET /exchange/:id/close_exchange" do
    it "switches the exchange state to closed" do
    end
  end

  describe "GET /exchange/:id/sign_up" do
    it "signs a user up for an exchange" do
      login(user)
      exchange

      visit dashboard_path

      click_link "Sign up for #{exchange.name}"
      page.should have_content("You have signed up for #{exchange.name}")
    end
  end
end
