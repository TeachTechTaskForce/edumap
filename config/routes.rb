Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'lessons#index'

  get 'lessons/saved_lessons' => 'lessons#saved_lessons', as: :saved_lessons
  get 'lessons/load_lessons' => 'lessons#load_lessons', as: :load_lessons

  post 'sessions/add_lesson/:lesson' => 'sessions#add_lesson', as: :add_lesson
  post 'sessions/remove_lesson/:lesson' => 'sessions#remove_lesson', as: :remove_lesson
  post 'sessions/send_lessons' => 'sessions#send_lessons', as: :send_lessons

  get '/contact' => 'contact#new', as: :contact
  post '/contact' => 'contact#create', as: :contact_go

  get '/about' => 'static_pages#about'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  resources :codes

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
