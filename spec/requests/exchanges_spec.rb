require 'spec_helper'

describe "Exchanges" do
  let(:user) {FactoryGirl.create(:nobody)}
  let(:user2) {FactoryGirl.create(:nobody)}
  let(:user3) {FactoryGirl.create(:nobody)}
  let(:user4) {FactoryGirl.create(:nobody)}
  let(:user5) {FactoryGirl.create(:nobody)}
  let(:user6) {FactoryGirl.create(:nobody)}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:exchange) {FactoryGirl.create(:exchange)}
  let(:exchange1) {FactoryGirl.create(:exchange)}
  let(:exchange2) {FactoryGirl.create(:exchange)}
  let(:photo) { FactoryGirl.create(:photo, user: user) }

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
    it "switches the exchange state to matched", :js => true do
      user.exchanges << exchange
      user2.exchanges << exchange
      user3.exchanges << exchange
      user4.exchanges << exchange
      user5.exchanges << exchange
      user6.exchanges << exchange
      login(admin)

      visit admin_path
      page.should have_content("7 registered users")
      page.should have_content("6 participants")
      click_link "Run matchups and notify users"
      page.should have_content("Close matchup")
      ActionMailer::Base.deliveries.last.bcc.should == [user.email, user2.email, user3.email, user4.email, user5.email, user6.email]

      visit dashboard_path
      page.should_not have_content("your match:")

      click_link admin.name
      click_link "Sign out"

      login(user)
      visit dashboard_path
      page.should have_content("your match:")
      click_link user.your_match(exchange).name
      page.should have_content "Address"
      visit user_path(admin)
      page.should_not have_content "Address"
    end
  end

  describe "GET /exchange/:id/close_exchange" do
    it "switches the exchange state to closed", :js => true do
      user.exchanges << exchange
      user2.exchanges << exchange
      user3.exchanges << exchange
      user4.exchanges << exchange
      user5.exchanges << exchange
      user6.exchanges << exchange
      login(admin)

      visit admin_path
      click_link "Run matchups and notify users"
      page.should have_content("Close matchup")
      click_link "Close matchup"
      ActionMailer::Base.deliveries.last.bcc.should == [user.email, user2.email, user3.email, user4.email, user5.email, user6.email]

      click_link admin.name
      click_link "Sign out"

      login(user)
      visit dashboard_path
      page.should have_content("Receive your gift?")
      click_link "Post my gift on the blog"
      fill_in "Title", :with => "A Sample post title"
      fill_in "Body", :with => "this is what the post says"
      click_link I18n.t('links.add_a_photo')
      fill_in "Photo Title", :with => "A sample photo title"
      fill_in "Photo Caption", :with => "this is the photo caption"
      attach_file("File Upload","#{Rails.root}/spec/samples/hutchhead.png")
      click_button I18n.t('buttons.create_post')
      page.should have_content("A Sample post title")
      page.should have_content("A sample photo title")
      page.should have_content("this is the photo caption")
      page.should have_css('img', :src => photo.image.url(:thumb))
      page.should have_content(exchange.name)
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

  describe "GET /exchange/:id/quit" do
    it "signs a user up for an exchange" do
      login(user)
      user.exchanges << exchange

      visit dashboard_path

      click_link "Quit this exchange"
      page.should have_content("You have quit #{exchange.name}")
    end
  end
end
