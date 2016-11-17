class SearchController < ApplicationController

  def index
    @lat = params[:lat]
    @lng = params[:lng]
  end

  def search_near_json
    @total = []
    @lat = params[:lat].to_f.degrees_to_radians
    @lng = params[:lng].to_f.degrees_to_radians
    @products = Product.search_near @lat, @lng
    @products.each do |product|
      #something weird is going on here ;(
      if product[0]
        image = ActionController::Base.helpers.asset_path("noPicture.png")
        user_image = ActionController::Base.helpers.asset_path("profile.png")
        new_product = Product.find product[0].id
        if new_product.images.first
          image = new_product.images.first.original
        end
        if new_product.user.images.first
          user_image = new_product.user.images.first.original
        end
        @total.push([product[0],product[0].place.lat,product[0].place.lng,image,user_image])
      end
    end
    render json: @total
  end

end

class Numeric

  def degrees_to_radians
    self * Math::PI / 180
  end
  
end
