class Category < ActiveRecord::Base
  
  has_many :products
  has_one :image

  def self.get_random quantity
    limit(quantity).order("RANDOM()")
  end

end
