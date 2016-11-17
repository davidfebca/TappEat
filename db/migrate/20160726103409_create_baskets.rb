class CreateBaskets < ActiveRecord::Migration
  def change
    create_table :baskets do |t|
      t.string :session
      t.timestamps null: false
    end
  end
end
