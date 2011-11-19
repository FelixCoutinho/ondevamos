class RestaurantesController < ApplicationController
  def index
    @restaurantes = Restaurante.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @restaurante = Restaurante.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @restaurante = Restaurante.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @restaurante = Restaurante.find(params[:id])
  end

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

  def destroy
    @restaurante = Restaurante.find(params[:id])
    @restaurante.destroy

    respond_to do |format|
      format.html { redirect_to(restaurantes_url, :notice => 'Restaurante foi removido com sucesso.') }
    end
  end
end
