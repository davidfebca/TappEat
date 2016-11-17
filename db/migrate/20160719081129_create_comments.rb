class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :rating
      t.boolean :published
      t.boolean :new
      t.timestamps null: false
      t.belongs_to :user, index: true
      t.belongs_to :product, index: true
    end
  end
end
