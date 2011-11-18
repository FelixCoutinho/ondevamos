class VotosController < ApplicationController
  def index
    @voto = Voto.new
    @voto.usuario = Usuario.all.first
    @voto.data = Date.today
    @restaurantes = Restaurante.all
    @jaVotou = @voto.jaVotou @voto.usuario
    if @jaVotou
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Restaurante') 
      data_table.new_column('number', 'Voto(s)') 
      @voto.contagemVotacao.each do |voto|
          data_table.add_row([voto.label, voto.total])
        end
      option = { width: 860, height: 300 }
      @chart = GoogleVisualr::Interactive::PieChart.new(data_table, option)
    end
  end

  def create
    @voto = Voto.new(params[:voto])
    @voto.data = Date.today
    @voto.usuario_id = Usuario.all.first.id
    
    if @voto.save
      @restaurantes = Restaurante.all
      flash[:notice] = 'Seu voto foi recebido.'
      @jaVotou = @voto.jaVotou Usuario.all.first
      redirect_to :action => "index"
    else
      @restaurantes = Restaurante.all
      render :action => "index"
    end
  end
end

