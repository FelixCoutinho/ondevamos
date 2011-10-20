class VotosController < ApplicationController
  def index
    @voto = Voto.new
    @voto.usuario = Usuario.all.first
    @voto.data = Date.today
    @restaurantes = Restaurante.all
  end

  # POST /votos
  def create
    @voto = Voto.new(params[:voto])

    respond_to do |format|
      if @voto.save
        @restaurantes = Restaurante.all
        format.html { redirect_to(@voto, :notice => 'Almoco was successfully created.') }
      else
        @restaurantes = Restaurante.all
        format.html { render :action => "index" }
      end
    end
  end
end

