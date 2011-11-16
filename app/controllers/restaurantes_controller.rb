class RestaurantesController < ApplicationController
  def index
    @restaurantes = Restaurante.all

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

    if @restaurante.save
      flash[:notice] = 'Restaurante foi adicionado com sucesso.'
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end

  def update
    @restaurante = Restaurante.find(params[:id])

    respond_to do |format|
      if @restaurante.update_attributes(params[:restaurante])
        flash[:notice] = 'Restaurante foi atualizado com sucesso.'
        redirect_to :action => "index"
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @restaurante = Restaurante.find(params[:id])
    @restaurante.destroy

    respond_to do |format|
       flash[:notice] = 'Restaurante foi removido com sucesso.'
        redirect_to :action => "index"
    end
  end
  
  def count
    respond_to do |format|
      format.js { render :json => Restaurante.count }
    end
  end
  
  def todos
    respond_to do |format|
      format.js { render :json => Restaurante.all }
    end
  end
end
