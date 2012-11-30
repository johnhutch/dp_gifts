class AddExchangeIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :exchange_id, :integer
  end
end
