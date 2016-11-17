class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.belongs_to :user, index:true
      t.timestamps null: false
      t.boolean :completed
      t.float :total
    end
  end
end
