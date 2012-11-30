class CreateExchangesUsersTable < ActiveRecord::Migration
  def up
    create_table :exchanges_users, :id => false do |t|
        t.references :exchange
        t.references :user
    end
    add_index :exchanges_users, [:exchange_id, :user_id]
    add_index :exchanges_users, [:user_id, :exchange_id]
  end

  def down
    drop_table :exchanges_users
  end
end
