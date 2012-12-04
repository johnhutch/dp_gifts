class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.integer :user_id
      t.integer :match_id
      t.integer :exchange_id

      t.timestamps
    end
  end
end
