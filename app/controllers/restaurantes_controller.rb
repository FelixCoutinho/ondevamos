class RestaurantesController < ApplicationController
  # Faz com que esse controller passe pelo filtro de autenticação
  before_filter :authenticate_usuario!

  # Action inicial
  def index
    @restaurantes = Restaurante.all

    respond_to do |format|
      format.html
    end
  end

  # Inicia o processo de criação de um restaurante
  def new
    @restaurante = Restaurante.new

    respond_to do |format|
      format.html
    end
  end

  # Abre um restaurante para edição
  def edit
    @restaurante = Restaurante.find(params[:id])
  end

  # Cria um restaurante
  def create
    @restaurante = Restaurante.new(params[:restaurante])

    respond_to do |format|
      if @restaurante.save
        format.html { redirect_to(restaurantes_url, :notice => 'Restaurante foi adicionado com sucesso.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # Atualiza um restaurante
  def update
    @restaurante = Restaurante.find(params[:id])

    respond_to do |format|
      if @restaurante.update_attributes(params[:restaurante])
        format.html { redirect_to(restaurantes_url, :notice => 'Restaurante foi atualizado com sucesso.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # Remove um restaurante
  def destroy
    @restaurante = Restaurante.find(params[:id])
    @restaurante.destroy

    respond_to do |format|
      format.html { redirect_to(restaurantes_url, :notice => 'Restaurante foi removido com sucesso.') }
    end
  end
end
