class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.string :name
      t.string :state
      t.text :description
      t.text :summary

      t.timestamps
    end
  end
end
