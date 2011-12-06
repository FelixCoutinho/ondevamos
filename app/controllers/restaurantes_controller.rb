class RestaurantesController < ApplicationController
  # Faz com que esse controller passe pelo filtro de autenticação
  before_filter :authenticate_usuario!

  autocomplete :restaurante, :nome do |items|
     CustomJSON::Encoder.encode(items)
  end

  # Action inicial
  def index
    @restaurantes = Restaurante.all
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
    if @restaurante.save
      redirect_to(restaurantes_url, :notice => 'Restaurante foi adicionado com sucesso.')
    else
      render :action => "new"
    end
  end

  # Atualiza um restaurante
  def update
    @restaurante = Restaurante.find(params[:id])

    if @restaurante.update_attributes(params[:restaurante])
      redirect_to(restaurantes_url, :notice => 'Restaurante foi atualizado com sucesso.')
    else
      render :action => "edit"
    end
  end

  # Remove um restaurante
  def destroy
    @restaurante = Restaurante.find(params[:id])
    @restaurante.destroy

    redirect_to(restaurantes_url, :notice => 'Restaurante foi removido com sucesso.')
  end

  def search
    Restaurante.all.to_json
  end
end
