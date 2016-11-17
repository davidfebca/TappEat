class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :user, index: true
      t.belongs_to :product, index: true
      t.belongs_to :category, index: true
      t.attachment :original
      t.timestamps null: false
    end
  end
end
