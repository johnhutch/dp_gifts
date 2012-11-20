class AddLikesToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :likes, :text
  end
end
