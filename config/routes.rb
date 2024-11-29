Rails.application.routes.draw do
  # Deviseのルートを先に定義
  devise_for :users

  # ルートパスの設定
  root to: 'homes#top'

  # その他のルート
  get 'home/about' => 'homes#about', as: 'about'
  resources :books
  resources :users, only: [:index, :show, :edit, :update]
end
