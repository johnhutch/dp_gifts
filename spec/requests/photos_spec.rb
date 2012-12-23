require 'spec_helper'

describe "Photos" do
  let(:user) {FactoryGirl.create(:nobody)}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:author) {FactoryGirl.create(:author)}
  let(:uploader) {FactoryGirl.create(:uploader)}
  let(:uploader2) {FactoryGirl.create(:uploader)}

  let(:photo) { FactoryGirl.create(:photo, user: uploader) }
  let(:photo2) { FactoryGirl.create(:photo, user: uploader) }
  let(:photo3) { FactoryGirl.create(:photo, user: uploader) }

  describe "GET /photos" do
    it "displays photos" do
      photo
      photo2
      photo3

      visit photos_path
      page.should have_css('img', :src => photo.image.url(:thumb))
      page.should have_css('img', :alt => photo.title)
      page.should have_css('img', :alt => photo2.title)
      page.should have_css('img', :alt => photo3.title)
    end
  end
  
  describe "GET /photos/:id" do
    it "displays a single photo" do
      visit photo_path(photo)
      page.should have_css('img', :src => photo.image.url(:thumb))
      page.should have_css('img', :alt => photo.title)
    end
  end

  describe "POST /photos" do
    it "should allow an uploader to photo a photo" do
      login(uploader)

      visit new_photo_path
      fill_in "Caption", :with => "this is the photo caption"
      attach_file("Image","#{Rails.root}/spec/samples/hutchhead.png")
      click_button I18n.t('buttons.create_photo')
      page.should have_content("this is the photo caption")
      page.should have_css('img', :src => photo.image.url(:thumb))
      page.should have_content(uploader.name)
    end
    
    it "should not allow a vanilla user to photo a photo" do
      login(user)
      
      visit new_photo_path
      page.should have_content("You are not authorized")
    end
  end

  describe "EDIT /photo/:id" do
    it "should allow the uploader to edit a photo" do
      login(uploader)

      visit edit_photo_path(photo)
      fill_in "Title", :with => "An edited photo title"
      attach_file("Image","#{Rails.root}/spec/samples/mark.jpg")
      click_button I18n.t('buttons.edit_photo')
      page.should have_content( I18n.t('flash.photo_updated'))
      page.should have_content('An edited photo title')
      page.should have_css('img', :src => photo2.image.url(:thumb))
    end
    
    it "should not allow a vanilla user to edit a photo" do
      login(user)
      
      visit edit_photo_path(photo)
      page.should have_content("You are not authorized")
    end
    
    it "should not allow a different uploader to edit a photo" do
      login(uploader2)
      
      visit edit_photo_path(photo)
      page.should have_content("You are not authorized")
    end

    it "should allow an admin to edit another photo" do
      login(admin)
      
      visit edit_photo_path(photo)
      fill_in "Title", :with => "An edited photo title"
      attach_file("Image","#{Rails.root}/spec/samples/mark.jpg")
      click_button I18n.t('buttons.edit_photo')
      page.should have_content( I18n.t('flash.photo_updated'))
      page.should have_content('An edited photo title')
      page.should have_css('img', :src => photo2.image.url(:thumb))
    end
  end
  
  let(:auth_ability) { Ability.new(uploader) }
  let(:auth2_ability) { Ability.new(uploader2) }

  describe "destroy abilities" do
    it "should allow the uploader to destroy photo" do
      auth_ability.should be_able_to(:destroy, photo)
    end

    it "should now allow another uploader to destroy photo" do
      auth2_ability.should_not be_able_to(:destroy, photo)
    end
  end
end
