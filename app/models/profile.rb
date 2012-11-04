class Profile < ActiveRecord::Base
  attr_accessible :address, :amazon_wishlist, :bio, :twitter, :user_id, :website

  belongs_to :user
end
