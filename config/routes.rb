Blog::Application.routes.draw do
  root :to => 'welcome#index'
  resources :articles
  resources :sage
end
