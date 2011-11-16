Ondevamos::Application.routes.draw do
  root :to => "votos#index"

  resources :usuarios

  match "/votos" => "votos#index", :via => :get
  match "/votos" => "votos#create", :via => :post
  match "/votos/count" => "votos#count", :via => :get
  match "/votos/count/restaurante/:id" => "votos#totalPorRestaurante", :via => :get
  
  match "/restaurantes" => "restaurantes#index", :via => :get
  match "/restaurantes/new" => "restaurantes#new", :via => :get
  match "/restaurantes" => "restaurantes#create", :via => :post
  match "/restaurantes/:id/edit" => "restaurantes#edit", :via => :get
  match "/restaurantes/:id" => "restaurantes#update", :via => :put
  match "/restaurantes/:id" => "restaurantes#destroy", :via => :delete
  match "/restaurantes/count" => "restaurantes#count", :via => :get
  match "/restaurantes/todos" => "restaurantes#todos", :via => :get

end

