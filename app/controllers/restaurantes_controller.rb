class RestaurantesController < ApplicationController
  # Faz com que esse controller passe pelo filtro de autenticação
  before_filter :authenticate_usuario!

  # Action inicial
  def index
    @restaurantes = Restaurante.order(:nome).all
  end

  # Inicia o processo de criação de um restaurante
  def new
    @restaurante = Restaurante.new
  end

  # Abre um restaurante para edição
  def edit
    @restaurante = Restaurante.find(params[:id])
  end

  # Cria um restaurante
  def create
    @restaurante = Restaurante.new(params[:restaurante])
    @restaurante.usuario = current_usuario
    if @restaurante.save
      redirect_to(restaurantes_url, :notice => 'Restaurante foi adicionado.')
    else
      render :action => "new"
    end
  end

  # Atualiza um restaurante
  def update
    @restaurante = Restaurante.find(params[:id])
    if @restaurante.update_attributes(params[:restaurante])
      redirect_to(restaurantes_url, :notice => 'Restaurante foi atualizado.')
    else
      render :action => "edit"
    end
  end

  # Remove um restaurante
  def destroy
    @restaurante = Restaurante.find(params[:id])
    @restaurante.destroy
    redirect_to(restaurantes_url, :notice => 'Restaurante foi removido.')
  end

  def search
    @restaurantes = Grupo.find(params[:grupo_id]).restaurantes
    render :partial => "search.html", :collection => @restaurantes, :layout => false
  end
end
