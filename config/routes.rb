Ondevamos::Application.routes.draw do
  # Definindo que a página inicial do sistema será a página inicial do
  # controller de votos.
  root :to => "votos#index"
  
  namespace :usuario do
    root :to => "votos#home"
  end
  
  # Configuração para que o Devise considere o recurso 'usuarios' para fazer
  # a autenticação do sistema.
  devise_for :usuarios

  # Configurando as rotas padrões para o controller de 'restaurantes'
  resources :restaurantes

  # Rotas para os votos
  # Página inicial
  match "/votos" => "votos#index", :via => :get
  match "/votos/home" => "votos#home", :via => :get
  # Submissão para página de criação do voto
  match "/votos" => "votos#create", :via => :post
  
  # Links do menu
  match "/sobre" => "menu#sobre", :via => :get
  match "/contato" => "menu#contato", :via => :get
end

