Ondevamos::Application.routes.draw do
  devise_for :usuarios

  root :to => "votos#index"

  resources :restaurantes

  match "/votos" => "votos#index", :via => :get
  match "/votos" => "votos#create", :via => :post

  match "/usuarios/new" => "usuarios#new", :via => :get
  match "/usuarios" => "usuarios#create", :via => :post
end

