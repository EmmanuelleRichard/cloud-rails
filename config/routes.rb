Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'users/registrations'}
  match "browse/:folder_id/new_file" => "archives#new", :via => [:get], :as => "new_sub_file"
  match 'browse/:folder_id' => 'home#browse', :via => [:get], :as => 'browse'
  match "browse/:folder_id/new_folder" => "folders#new", :via => [:get], :as => "new_sub_folder"
  root 'home#index'
  match "archives/get/:id" => "archives#get", :via => [:get], :as => "download"


  resources :folders
  resources :archives
  resources :archives
  resources :assets, path: "asset", only: [:new, :create, :index]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
