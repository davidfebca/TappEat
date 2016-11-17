class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.string :content
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
