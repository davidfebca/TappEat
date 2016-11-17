class Testimonial < ActiveRecord::Base
  belongs_to :user

  def self.get_random quantity
    limit(quantity).order("RANDOM()")
  end
  
end
