# encoding: UTF-8
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
    @grupo = Grupo.where(:usuario_id => current_usuario).find(params[:id])

    if @grupo.update_attributes(params[:grupo])
      redirect_to(grupos_url, :notice => 'Grupo foi atualizado com sucesso.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @grupo = Grupo.where(:usuario_id => current_usuario).find(params[:id])
    @grupo.destroy

    redirect_to(grupos_url, :notice => 'Grupo foi removido com sucesso.')
  end

  def edit
    @grupo = Grupo.where(:usuario_id => current_usuario).find(params[:id])
  end

  def show
    @grupos = Grupo.where(:usuario_id => current_usuario)
    @restaurante = Restaurante.new
  end

  def associarRestaurante
    @restaurante = Restaurante.find(params[:restaurante][:id])
    @grupo = Grupo.where(:usuario_id => current_usuario).find(params[:grupo_id])
    if @grupo.restaurantes.include? @restaurante
      redirect_to(@grupo, :info => 'Restaurante já está associado ao grupo.')
    else
      @grupo.restaurantes << @restaurante
      @grupo.save
      redirect_to(@grupo, :notice => 'Restaurante foi associado ao grupo com sucesso.')
    end
  end

  def desassociarRestaurante
    @grupo = Grupo.where(:usuario_id => current_usuario).find(params[:grupo_id])
    @restaurante = Restaurante.find(params[:id])
    @grupo.restaurantes.delete @restaurante
    redirect_to(@grupo, :notice => 'Restaurante foi desassociado do grupo com sucesso.')
  end

  def associarUsuario
    @usuario = current_usuario
    @grupo = Grupo.find(params[:grupo_id])
    if @grupo.usuarios.include? @usuario
      redirect_to(grupos_path, :info => 'Usuário já está associado ao grupo.')
    else
      @grupo.usuarios << @usuario
      @grupo.save
      redirect_to(grupos_path, :notice => 'Usuário foi associado ao grupo com sucesso.')
    end
  end

  def desassociarUsuario
    @usuario = current_usuario
    @grupo = Grupo.find(params[:grupo_id])
    if @grupo.usuarios.include? @usuario
      @grupo.usuarios.delete @usuario
      redirect_to(grupos_path, :notice => 'Usuário foi desasociado do grupo com sucesso.')
    else
      redirect_to(grupos_path, :info => 'Usuário não estava associado ao grupo.')
    end
  end
end
