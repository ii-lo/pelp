Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, path: ''
  resources :users

  authenticated :user do
    root 'users#dashboard', as: :dashboard
  end

  authenticate :user do
    resources :courses do
      member do
        get :grades
        get :activity
        get :info
        get :settings
        get '/exams/:exam_id' => :exam, as: :exam
      end
    end

    resources :messages
    #get 'messages' => 'messages#index', as: :messages
    get 'messages/ajax/page' => 'messages#page'
    get 'messages/ajax/test' => 'messages#test'

    get '/exam/new/:id' => 'user_exams#new', as: :new_user_exam
    get '/exam/question' => 'user_exams#question', as: :question_user_exam
    post '/exam/answer' => 'user_exams#answer', as: :answer_user_exam

    get 'calendar' => 'calendar#show', as: :calendar
  end

  unauthenticated do
    root 'static_pages#home'
  end

  get '/help' => 'static_pages#help', as: :help
  get '/privacy' => 'static_pages#privacy', as: :privacy
  get '/rules' => 'static_pages#rules', as: :rules


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
