Rails.application.routes.draw do

  post '/ajax/products/delete', to:'products#delete'
  post '/ajax/shoppingcart/delete', to:'shoppingcart#delete_item'

  scope '/(:locale)', defaults: { locale: 'en' }, constraints: { locale: /en|es/ } do
    root to: 'home#index'
    devise_for :users
    resources :users
    resources :products
    resources :charges
    get '/my-account', to:'account#index'
    get '/user/profile/:id', to:'users#public_profile', as: 'public_profile'
    get '/search', to:'search#index'
    get '/basket', to:'shoppingcart#basket', as: 'basket'
    get '/checkout', to:'shoppingcart#checkout', as: 'checkout'
    get '/products/details/:id', to:'products#details', as: 'products_details'
    get '/search/search_near_json', to:'search#search_near_json'
    get '404', to: 'application#page_not_found', as: 'not_found'
    post '/shoppingcart/add_item', to:'shoppingcart#add_item', as:'add_item'
    post '/shoppingcart/new_purchase', to:'shoppingcart#new_purchase', as: 'new_purchase'
    post '/account/update_image', to:'account#update_image', as: 'update_user_image'
    post '/products/new_comment', to:'products#new_comment', as: 'new_comment'
  end
end
