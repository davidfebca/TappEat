class ShoppingcartController < ApplicationController

  before_filter :authenticate_user!, :only => [:checkout]
  before_action do
    @session_id = session["session_id"];
    @basket_service = ShoppingCartService.new(@session_id)
  end

  def add_item
    product_id = params[:product_id]
    quantity = params[:quantity]
    @basket_service.add_item(product_id,quantity)
    redirect_to products_details_path id:product_id
  end

  def delete_item
    product_id = params[:id]
    @basket_service.delete_item(product_id)
    render json: {status:200}
  end

  def basket
    @products = self.get_basket_products
    @total = @basket_service.get_total
  end

  def checkout
    @purchase = Purchase.find params[:ref].to_i
    @total = @purchase.total
    @products = []
    @purchase.items.each do |item|
      product = Product.find item.product_id
      @products.push([product,item.quantity])
    end
    @products
  end

  def new_purchase
    purchase = @basket_service.new_purchase current_user
    redirect_to checkout_path ref:purchase.id
  end

  protected
  def get_basket_products
    @products = []
    basket = @basket_service.get_basket
    basket.items.each do |item|
      product = Product.find item.product_id
      stock_service = StockService.new product
      #get real stock
      product.stock = stock_service.get_stock
      @products.push([product,item.quantity])
    end
    @products
  end
  
end
