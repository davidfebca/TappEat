class ProductService

  def self.update_product user_id, params
    product = nil
    if params[:id] != ""
      product = Product.find params[:id].to_i
    end
    if product.nil?
      product = Product.new
    end
    product.user_id = user_id
    product.title = params[:title]
    product.short_description = params[:short_description]
    product.price = params[:price]
    product.expiration = params[:expiration]
    product.description = params[:description]
    product.stock = params[:stock]
    product.featured = true
    category = Category.find_by id: params[:category_id]
    if category
      product.category = category
    end
    if params[:lat] != ""
      lat = params[:lat].to_f * (Math::PI / 180)
      lng = params[:lng].to_f * (Math::PI / 180)
      location = Place.create(lat:lat,lng:lng)
      product.place = location
    end
    if params[:image]
      product.images = [Image.create(original:params[:image], product_id:product.id)]
    end
    product.save
    product
  end

  def self.delete id
    product = Product.find id
    product.destroy
  end

end
