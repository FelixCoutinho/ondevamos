class VotosController < ApplicationController
  def index
    @voto = Voto.new
    @voto.usuario = Usuario.all.first
    @restaurantes = Restaurante.all
    @jaVotou = @voto.jaVotou @voto.usuario
  end

  # POST /votos
  def create
    @voto = Voto.new(params[:voto])
    @voto.data = Date.today
    
    if @voto.save
      @restaurantes = Restaurante.all
      flash[:notice] = 'Seu voto foi recebido.'
      redirect_to :action => "index"
    else
      @restaurantes = Restaurante.all
      render :action => "index"
    end
  end
end

