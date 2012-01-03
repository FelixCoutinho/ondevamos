Ondevamos::Application.routes.draw do
  # Definindo que a página inicial do sistema será a página inicial do
  # controller de votos.
  root :to => "votos#index"

  match '/usuario' => "votos#home", :as => :usuario_root

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
  match "/grupos/associarRestaurante" => "grupos#associarRestaurante", :via => :post
  match "/grupos/desassociarRestaurante/:id/:grupo_id" => "grupos#desassociarRestaurante", :via => :delete
  match "/grupos/associarUsuario/:grupo_id" => "grupos#associarUsuario", :via => :get
  match "/grupos/desassociarUsuario/:grupo_id" => "grupos#desassociarUsuario", :via => :delete
  match "/grupos/usuarios/:grupo_id" => "grupos#listarUsuarios", :via => :get
  match "/grupos/autorizar/:membro_id" => "grupos#autorizarMembro", :via => :get
  match "/grupos/desautorizar/:membro_id" => "grupos#desautorizarMembro", :via => :delete

  # Rotas para os votos
  # Página inicial
  match "/votos" => "votos#index", :via => :get
  match "/votos/home" => "votos#home", :via => :get
  # Submissão para página de criação do voto
  match "/votos" => "votos#create", :via => :post, :as => :voto

  match "/votos/jaVotou/:grupo_id" => "votos#jaVotou", :via => :get

  # Links do menu
  match "/sobre" => "menu#sobre", :via => :get
  match "/contato" => "menu#contato", :via => :get
end
