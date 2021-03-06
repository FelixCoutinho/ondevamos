# encoding: UTF-8
class VotosController < ApplicationController
  # Faz com que esse controller passe pelo filtro de autenticação
  before_filter :authenticate_usuario!, :except => [:index]

  def index

  end

  # Action inicial do controller de votos
  def home
    @voto = Voto.new
    @voto.usuario = Usuario.find(current_usuario.id)
    @voto.data = Date.today
    @grupos = Grupo.where(:usuario_id => current_usuario)
    @grupos = @grupos + @voto.usuario.grupos
  end

  # Adiciona/cria um voto
  def create
    @voto = Voto.new(params[:voto])
    # Usuário que está autenticado
    @voto.usuario = Usuario.find(current_usuario.id)
    # Simulando o formulário para validação do ActiveRecord
    @voto.usuario_id = current_usuario.id
    @grupos = Grupo.where(:usuario_id => current_usuario)
    @grupos = @grupos + @voto.usuario.grupos
    @voto.data = Date.today
    @restaurantes = Grupo.find(@voto.grupo).restaurantes.order(:nome)
    if @voto.valid?
      @grupo = Grupo.find(@voto.grupo)
      @jaVotou = @voto.jaVotou @voto.usuario, @grupo
      if @jaVotou
        flash[:notice] = 'Desculpe, mas você só pode ter apenas 1(um) voto por dia.'
        redirect_to :action => "home"
      elsif @voto.save
        # Google Visualizer (Gráfico da votação)
        data_table = GoogleVisualr::DataTable.new
        data_table.new_column('string', 'Restaurante')
        data_table.new_column('number', 'Voto(s)')
        @voto.contagemVotacao(@grupo).each do |voto|
          data_table.add_row([voto.label, voto.total.to_i])
        end
        option = { width: 527.8, height: 300 }
        # Configurando para gráfico de estilo 'pizza'
        @chart = GoogleVisualr::Interactive::PieChart.new(data_table, option)
        flash[:notice] = 'Seu voto foi recebido.'
        @jaVotou = @voto.jaVotou @voto.usuario, @grupo
        render :action => "home"
      else
        render :action => "home"
      end
    else
      render :action => "home"
    end
  end

  def jaVotou
    @voto = Voto.new
    @grupo = Grupo.find(params[:grupo_id])
    @jaVotou = @voto.jaVotou current_usuario, @grupo
    @voto = Voto.new
    @voto.usuario = Usuario.find(current_usuario.id)
    @voto.data = Date.today
    @voto.grupo = @grupo
    if @jaVotou
      # Google Visualizer (Gráfico da votação)
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Restaurante')
      data_table.new_column('number', 'Voto(s)')
      @voto.contagemVotacao(@grupo).each do |voto|
          data_table.add_row([voto.label, voto.total.to_i])
        end
      option = { width: 527.8, height: 300 }
      # Configurando para gráfico de estilo 'pizza'
      @chart = GoogleVisualr::Interactive::PieChart.new(data_table, option)
    else
      @grupos = Grupo.where(:usuario_id => current_usuario)
      @grupos = @grupos + @voto.usuario.grupos
      @restaurantes = @grupo.restaurantes
    end
    render :partial => "votacao.html", :layout => false
  end
end
