# encoding: UTF-8
class VotosController < ApplicationController
  # Faz com que esse controller passe pelo filtro de autenticação
  before_filter :authenticate_usuario!, :except => [:index]

  def index

  end

  # Action inicial do controller de votos
  def home
    @voto = Voto.new
    @grupos = Grupo.where(:usuario_id => current_usuario)
    # Resgatando usuário que está autenticado
    @voto.usuario = Usuario.find(current_usuario.id)
    @voto.data = Date.today
    @grupo = @grupos.first
    @restaurantes = @grupo.restaurantes
    @jaVotou = @voto.jaVotou @voto.usuario, @grupo
    #Verificando se o usuário já votou no dia de hoje
    if @jaVotou
      # Google Visualizer (Gráfico da votação)
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Restaurante')
      data_table.new_column('number', 'Voto(s)')
      @voto.contagemVotacao(@grupos.first).each do |voto|
          # Depois da migração para Postgres foi necessário transformar o total
          # em Integer
          data_table.add_row([voto.label, voto.total.to_i])
        end
      option = { width: 527.8, height: 300 }
      # Configurando para gráfico de estilo 'pizza'
      @chart = GoogleVisualr::Interactive::PieChart.new(data_table, option)
    end
  end

  # Adiciona/cria um voto
  def create
    logger.info params
    @voto = Voto.new(params[:voto])
    @grupos = Grupo.where(:usuario_id => current_usuario)
    @voto.data = Date.today
    # Usuário que está autenticado
    @voto.usuario = Usuario.find(current_usuario.id)
    # Simulando o formulário para validação do ActiveRecord
    @voto.usuario_id = current_usuario.id
    @grupo = Grupo.where(:usuario_id => current_usuario).find(@voto.grupo)
    @jaVotou = @voto.jaVotou @voto.usuario, @grupo
    if @jaVotou
      @restaurantes = Restaurante.all
      flash[:notice] = 'Desculpe, mas você só pode ter apenas 1(um) voto por dia.'
      redirect_to :action => "home"
    elsif @voto.save
      @restaurantes = Restaurante.all
      flash[:notice] = 'Seu voto foi recebido.'
      # Fazendo verificação de existencia de voto
      # Foi necessário para forçar a re-checagem da tela e assim mostrar o
      # gráfico no momento após o voto ser salvo. E não precisar recarregar
      # a tela novamente
      @jaVotou = @voto.jaVotou @voto.usuario, @grupo
      redirect_to :action => "home"
    else
      @restaurantes = Restaurante.all
      render :action => "home"
    end
  end

  def jaVotou
    @voto = Voto.new
    @grupo = Grupo.where(:usuario_id => current_usuario).find(params[:grupo_id])
    @jaVotou = @voto.jaVotou current_usuario, @grupo
    #render :json => @jaVotou
    @voto = Voto.new
    @voto.usuario = Usuario.find(current_usuario.id)
    @voto.data = Date.today
    @restaurantes = Grupo.find(params[:grupo_id]).restaurantes
    render :partial => "home.html", :collection => @restaurantes, :layout => false
  end
end
