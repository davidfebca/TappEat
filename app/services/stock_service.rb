class StockService
  attr_reader :product

  def initialize product
      @product = product
  end

  def update_stock quantity
    @product.stock = @product.stock - quantity
    @product.save
  end

  def get_stock
    total_in_basket = 0
    products = Basket.all
    products.each do |product|
      count = product.items.where("product_id =#{@product.id}").reduce(0) do |sum, item|
        sum += item.quantity
      end
      total_in_basket += count
    end
    @product.stock - total_in_basket
  end
  
end
