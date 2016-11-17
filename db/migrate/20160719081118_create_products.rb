class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.string :short_description
      t.integer :rating,:default => 0
      t.float :price , :default => 0
      t.boolean :featured ,:default => false
      t.datetime :expiration
      t.timestamps null: false
      t.integer :stock ,:default => 0
      t.belongs_to :user, index: true
      t.belongs_to :place, index: true
      t.belongs_to :category, index: true
    end
  end
end
