module ApplicationHelper

  def products_in_basket
    basket = Basket.find_by session: session["session_id"];
    items_in_basket = 0
    if basket
      items_in_basket = basket.items.reduce(0) do |sum, item|
        sum += item.quantity
      end
    end
  end
  
end
