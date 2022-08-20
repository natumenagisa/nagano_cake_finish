Rails.application.routes.draw do
  #管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  #顧客用
  devise_for :customers,skip: [:passwords], controllers: {
  sessions: 'public/sessions'
  }

  root 'public/homes#top'
  get 'about' => 'public/homes#about'

  scope module: :public do
    resources :items, only: [:index,:show]
    resource :customers, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end

    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete 'destroy_all'
      end
    end

    resources :orders, only: [:new, :create, :index, :show,] do
      collection do
        post 'comfirm'
        get 'complete'
      end
    end

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end



  namespace :admin do
    root 'homes#top'
    resources :homes, only: [:top]
    resources :customers, only: [:index, :show, :edit, :update]
      resources :items, only: [:index,:new,:create,:show,:edit,:update]
      resources :genres, only: [:index, :create, :edit, :update]
      resources :orders, only: [:show, :update]
      resource :order_derails, only: [:update]
  end
end