class AlmocosController < ApplicationController
  # GET /almocos
  def index
    @almocos = Almoco.all
    @voto = Voto.new
    @restaurantes = Restaurante.all
  end

  # GET /almocos/new
  def new
    @almoco = Almoco.new
    @almocos = Almoco.all
    @voto = Voto.new
    @restaurantes = Restaurante.all
  end

  # POST /almocos
  def create
    @almoco = Almoco.new(params[:almoco])

    respond_to do |format|
      if @almoco.save
        format.html { redirect_to(@almoco, :notice => 'Almoco was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /almocos/1
  def update
    @almoco = Almoco.find(params[:id])

    respond_to do |format|
      if @almoco.update_attributes(params[:almoco])
        format.html { redirect_to(@almoco, :notice => 'Almoco was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /almocos/1
  def destroy
    @almoco = Almoco.find(params[:id])
    @almoco.destroy
  end
end

