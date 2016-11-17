class ProductsController < ApplicationController

  before_action :authenticate_user!, :except => [:details, :get_products]

  def details
    @product = Product.find_by id: params[:id]
    unless @product
     redirect_to not_found_path
     return
    end
    @related = Product.get_random_by_category @product.category.id, 3
    @related = @related.where("id !=#{@product.id}")
    @comments = @product.comments.limit(5).order("RANDOM()")
    stock_service = StockService.new(@product)
    @stock = stock_service.get_stock
  end

  def get_products id_user
    user = User.find id_user
    if current_user != user
      render json: "error"
      return
    end
    products = Products.where('user_id = ?', id_user)
    render json: products
  end

  def create
    params = product_params
    product = ProductService.update_product current_user.id, params
    redirect_to controller:"account", action:"index"
  end

  def edit
    @product = Product.find params[:id]
    @categories = Category.all
  end

  def delete
    ProductService.delete params[:id]
    render json: {status:200}
  end

  def new_comment
    product = Product.find params[:id_product]
    unless product
     redirect_to not_found_path
     return
    end
    unless current_user
       redirect_to not_found_path
       return
    end
    # por ahora no hago moderación de comentarios.
    Comment.create(user:current_user,product:product,content: params[:content],published:true,new:false)
    redirect_to products_details_path id:product.id
  end

  private
  def product_params
    params.require(:product).permit(:id,:title, :short_description,:category_id, :price,:expiration,:description,:image,:stock,:lat,:lng)
  end
  
end
