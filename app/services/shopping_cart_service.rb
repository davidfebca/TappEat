class ShoppingCartService
  attr_reader :session,:basket
  attr_accessor :basket

  def initialize(session)
     @session = session
     @basket = self.set_basket
  end

  def destroy
    @basket.destroy
  end

  def get_basket
    @basket
  end

  def set_basket
    @basket = Basket.find_by session: @session
    if @basket.nil?
      @basket = Basket.create(session: @session)
    end
    @basket
  end

  def find_item product_id
    @basket.items.find_by product_id: product_id
  end

  def create_product product_id, quantity
    Item.create(basket:@basket,product_id:product_id,quantity:quantity)
  end

  def add_item product_id , quantity
    product = self.find_item product_id
    if product.nil?
      product = self.create_product(product_id,0)
    end
    product.quantity += quantity.to_i
    product.save
    @basket.save
  end

  def delete_item product_id
    product = self.find_item product_id
    if product.quantity > 1
      product.quantity = product.quantity - 1
      product.save
    else
      product.destroy
    end
  end

  def get_total
    total = 0
    @basket.items.each do |item|
      product = Product.find item.product_id
      if product
        subtotal = item.quantity * product.price
        total += subtotal
      end
    end
    total
  end

  def new_purchase user
    purchase = Purchase.new(user:user,total: self.get_total,completed:false)
    purchase_items = []
    @basket.items.each do |item|
      product = Product.find item.product_id
      item = Item.create(name:product.title, price:product.price, quantity:item.quantity,product_id:product.id)
      item.save
      purchase_items.push(item)
      stock_service = StockService.new(product)
      stock_service.update_stock item.quantity
    end
    purchase.items = purchase_items
    purchase.save
    @basket.destroy
    purchase
  end
  
end
