class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :bio
      t.string :amazon_wishlist
      t.string :twitter
      t.text :address
      t.string :website
      t.integer :user_id

      t.timestamps
    end
  end
end
