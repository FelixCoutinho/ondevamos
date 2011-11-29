class GruposController < ApplicationController
  # Faz com que esse controller passe pelo filtro de autenticação
  before_filter :authenticate_usuario!

  def index
    @grupos = Grupo.all
  end

  def new
    @grupo = Grupo.new
    @grupo.usuario = Usuario.find(current_usuario.id)
  end

  def create
    @grupo = Grupo.new(params[:grupo])
    @grupo.usuario_id = current_usuario.id

    if @grupo.save
      redirect_to(grupos_url, :notice => 'Grupo foi adicionado com sucesso.')
    else
      render :action => "new"
    end
  end

  def update
    @grupo = Grupo.find(params[:id])

    if @grupo.update_attributes(params[:grupo])
      redirect_to(grupos_url, :notice => 'Grupo foi atualizado com sucesso.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @grupo = Grupo.find(params[:id])
    @grupo.destroy

    redirect_to(grupos_url, :notice => 'Grupo foi removido com sucesso.')
  end

  def edit
    @grupo = Grupo.find(params[:id])
  end

  def associar

  end
end
