NoMoreIdeas::Application.routes.draw do
  devise_for :users,
    :path => '',
    :path_names => {
      :sign_up => 'register',
      :sign_in => 'login'
    },
    :controllers => {:registrations => 'registrations'}

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#root'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  post '/images'          => 'images#create'
  get '/images/:key'      => 'images#show',    as: 'image'
  get '/images/:key/edit' => 'images#edit',    as: 'edit_image'
  patch '/images/:key'    => 'images#update',  as: 'update_image'
  delete '/images/:key'   => 'images#destroy', as: 'destroy_image'

  # Declare album routes based on key.
  get '/albums/new'       => 'albums#new',     as: 'new_album'
  post '/albums'          => 'albums#create'
  get '/albums/:key'      => 'albums#show',    as: 'album'
  get '/albums/:key/edit' => 'albums#edit',    as: 'edit_album'
  patch '/albums/:key'    => 'albums#update',  as: 'update_album'
  delete '/albums/:key'   => 'albums#destroy', as: 'destroy_album'

  # Handle "add to album" or "delete" submissions.
  post '/images/edit_mode_submit' => 'images#edit_mode_submit', as: 'edit_mode_submit'

  get '/users/:username'        => 'users#show',   as: 'user'
  get '/users/:username/albums' => 'albums#index', as: 'show_user_albums'

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
