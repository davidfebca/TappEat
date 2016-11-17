class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :basket, index: true
      t.belongs_to :purchase, index: true
      t.integer :product_id
      t.integer :quantity
      t.string :name
      t.float :price
      t.timestamps null: false
    end
  end
end
