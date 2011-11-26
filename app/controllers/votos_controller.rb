class VotosController < ApplicationController
  # Faz com que esse controller passe pelo filtro de autenticação
  before_filter :authenticate_usuario!, :except => [:index]

  def index

  end

  # Action inicial do controller de votos
  def home
    @voto = Voto.new
    # Resgatando usuário que está autenticado
    @voto.usuario = current_usuario
    @voto.data = Date.today
    @restaurantes = Restaurante.all
    @jaVotou = @voto.jaVotou @voto.usuario 
    #Verificando se o usuário já votou no dia de hoje
    if @jaVotou
      # Google Visualizer (Gráfico da votação)
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Restaurante') 
      data_table.new_column('number', 'Voto(s)') 
      @voto.contagemVotacao.each do |voto|
          # Depois da migração para Postgres foi necessário transformar o total
          # em Integer
          data_table.add_row([voto.label, voto.total.to_i])
        end
      option = { width: 860, height: 300 }
      # Configurando para gráfico de estilo 'pizza'
      @chart = GoogleVisualr::Interactive::PieChart.new(data_table, option)
    end
  end

  # Adiciona/cria um voto
  def create
    @voto = Voto.new(params[:voto])
    @voto.data = Date.today
    # Usuário que está autenticado
    @voto.usuario_id = current_usuario.id
    
    if @voto.save
      @restaurantes = Restaurante.all
      flash[:notice] = 'Seu voto foi recebido.'
      # Fazendo verificação de existencia de voto
      # Foi necessário para forçar a re-checagem da tela e assim mostrar o
      # gráfico no momento após o voto ser salvo. E não precisar recarregar
      # a tela novamente
      @jaVotou = @voto.jaVotou current_usuario
      redirect_to :action => "index"
    else
      @restaurantes = Restaurante.all
      render :action => "index"
    end
  end
end

