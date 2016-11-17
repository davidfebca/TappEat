class AccountController < ApplicationController
  before_action :authenticate_user!
  before_action do
    @user = current_user
  end

  def index
    @user
    @product = Product.new
    @categories = Category.all
    @tappeats_sold = []
    @items_sold = []
    @product_comments = []
    purchases = Purchase.all
    #absolutamente NO hacerlo así, arreglar después de hackshow
    @user.products.each do |product|
      purchases.each do |purchase|
        items = purchase.items.select do |item|
            item.product_id = product.id
        end
        @items_sold.push(items)
      end
      product.comments.each do |comment|
        @product_comments.push(comment)
      end
    end
    @items_sold.each do |element|
      resultado = Purchase.find element[0].purchase_id
      @tappeats_sold.push(resultado)
    end
    @balance = @tappeats_sold.reduce(0) do |sum,purchase|
      sum += purchase.total
    end
  end

  def update_image
    image = Image.find_by user_id: current_user.id
    if image.nil?
      image = Image.new
    end
    image.user_id = current_user.id
    image.original = params[:image]
    image.save
    redirect_to my_account_path
  end

  private
  def person_params
    params.permit(:name,:direccion,:zip)
  end

end
