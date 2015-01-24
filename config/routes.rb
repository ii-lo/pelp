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
        get :settings
      end
      resources :exams, except: [:show]
      resources :lessons do
        resources :pictures, only: [:create, :destroy]
      end
      resources :material_categories, except: [:index, :edit] do
        resources :materials, only: [:create, :destroy]
      end
    end
    # resource for path names; actual exams resource in courses resource
    resources :exams, only: [] do
      resources :question_categories, only: [:create, :destroy, :update], path: 'q_cs/' do
        resources :questions, only: [:create, :update, :destroy]
      end
    end

    resources :questions, only: [] do
      resources :answers, only: [:create, :update, :destroy]
    end

    scope '/exam' do
      get '/start/:id' => 'user_exams#start', as: :start_user_exam
      get '/new/:id' => 'user_exams#new', as: :new_user_exam
      get '/exit' => 'user_exams#exit', as: :exit_user_exam
      get '/question' => 'user_exams#question', as: :question_user_exam
      get '/summary/:id' => 'user_exams#show', as: :user_exam
      post '/answer' => 'user_exams#answer', as: :answer_user_exam
    end

    get 'question_markdown/:id' => 'questions#get_markdown'
  end

  unauthenticated do
    root 'static_pages#home'
  end

  get '/help' => 'static_pages#help', as: :help
  scope '/help' do
    get '/privacy' => 'static_pages#privacy', as: :privacy
    get '/rules' => 'static_pages#rules', as: :rules
  end


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
