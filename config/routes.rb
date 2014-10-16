Blog::Application.routes.draw do
  get "sage/index"
  get "sage/callback"

  root :to => 'welcome#index'
  resources :articles
end
