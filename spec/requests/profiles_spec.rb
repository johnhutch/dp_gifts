require 'spec_helper'

describe "Profiles" do
  let(:user) {FactoryGirl.create(:user)}

  describe "GET /profiles" do
    it "creates a new profile for a new user" do
      login(user)
      visit edit_user_registration_path

      fill_in "Mailing Address", :with => "21 jump st.\nGenorocity, Denial 12345\nDonation"
      fill_in "Short Bio", :with => "Hi there. Lemme tell you about myself."
      fill_in "Amazon wishlist", :with => "http://www.amazon.com/blah"
      fill_in "Twitter Account", :with => "johnhutch"
      fill_in "Your Website", :with => "http://www.johnhutch.com"
      click_button I18n.t('buttons.update_profile')
      page.should have_content(I18n.t('flash.profile_updated'))
      page.should have_content('21 jump st.')
      page.should have_content('Lemme tell you about myself.')
    end

    it "updates a user's profile" do
    end

    it "does not allow a user to update another user's profile" do
    end
  end
end
