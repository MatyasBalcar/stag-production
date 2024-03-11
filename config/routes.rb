Rails.application.routes.draw do
  
  resources :predmets do
    collection do
      get :export
    end
  end
  resources :lectures do
    collection do
      get 'export', to: 'lectures#export', as: :export_lectures
    end

    member do
      put 'toggle_check'
      put :increase_start_time
      put :decrease_start_time
    end
  end
  resources :user_timetables do
    post 'import', on: :member
  
    collection do
      delete 'destroy_all'
    end
  end

  get 'timetable/index'
  get 'home/index'
  get 'quiz_test', to: 'home#quiz_test'
  get "up" => "rails/health#show", as: :rails_health_check
  get 'export_all', to: 'lectures#export_all'
  get 'search', to: 'search#index'
  
  post 'predmets/import', to: 'predmets#import', as: :import_predmets
  post 'lectures/import', to: 'lectures#import', as: :import_lectures
  post 'import_data', to: 'data_imports#import_inf_2'

  delete 'delete_all_predmets', to: 'predmets#delete_all'

  devise_for :users

  root 'home#index'
end