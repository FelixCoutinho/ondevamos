Ondevamos::Application.routes.draw do
  root :to => "votos#index"

  resources :usuarios, :restaurantes

  match "/votos" => "votos#index", :via => :get
  match "/votos" => "votos#create", :via => :post
end

