Ondevamos::Application.routes.draw do
  # Definindo que a página inicial do sistema será a página inicial do
  # controller de votos.
  root :to => "votos#index"

  #match '/usuario' => "votos#home", :as => :usuario_root

  # Configuração para que o Devise considere o recurso 'usuarios' para fazer
  # a autenticação do sistema.
  devise_for :usuarios

  # Configurando as rotas padrões para o controller de 'restaurantes'
  resources :restaurantes, :except => 'show'

  # Configurando as rotas padrões para o controller de 'grupos'
  resources :grupos

  # Busca de restaurantes
  match "/restaurantes/search/:grupo_id" => "restaurantes#search", :via => :get

  # Associar restaurante com grupo
  match "/grupos/associar" => "grupos#associar", :via => :post
  match "/grupos/desassociar/:id/:grupo_id" => "grupos#desassociar", :via => :delete

  # Auto complete de restaurante
  resources :restaurantes do
    get :autocomplete_restaurante_nome, :on => :collection
  end

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
