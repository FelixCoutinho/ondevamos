class VotosController < ApplicationController
  def index
    @voto = Voto.new
    @usuario = Usuario.all.first
    @voto.usuario = @usuario
    @restaurantes = Restaurante.all
    @jaVotou = @voto.jaVotou @voto.usuario
  end

  def create
    @voto = Voto.new(params[:voto])
    @voto.data = Date.today
    
    if @voto.save
      @restaurantes = Restaurante.all
      flash[:notice] = 'Seu voto foi recebido.'
      @jaVotou = @voto.jaVotou @usuario
      redirect_to :action => "index"
    else
      @restaurantes = Restaurante.all
      render :action => "index"
    end
  end
  
  def count
    respond_to do |format|
      format.js { render :json => Voto.count }
    end
  end
  
  def totalPorRestaurante
    respond_to do |format|
      format.js { render :json => Voto.count }
    end
  end
end

