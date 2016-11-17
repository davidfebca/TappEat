class HomeController < ApplicationController

  def index
    @products = Product.get_random_featured 3
    @categories = Category.get_random 4
    @testimonials = Testimonial.get_random 6
  end
  
end
