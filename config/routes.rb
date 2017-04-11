InsalesApp::Application.routes.draw do
  resources :variants
  resources :products do
    collection do
  		get :downloadproduct
  		get :updateproduct
    end
  end

  resource  :session do
    collection do
      get :autologin
    end
  end

  get '/install',   to: 'insales_app#install',   as: :install
  get '/uninstall', to: 'insales_app#uninstall', as: :uninstall
  get '/login',     to: 'sessions#new',          as: :login
  get '/main',      to: 'main#index',            as: :main

  root to: 'main#index'

end
