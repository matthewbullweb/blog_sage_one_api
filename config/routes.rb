Blog::Application.routes.draw do
  root :to => 'welcome#index'
  resources :articles
  resources :sage
  get "sage/callback"
  get "articles_controller/update"
end
