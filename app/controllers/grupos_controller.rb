# encoding: UTF-8
class GruposController < ApplicationController
  # Faz com que esse controller passe pelo filtro de autenticação
  before_filter :authenticate_usuario!

  def index
    @grupos = Grupo.order(:nome).all
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
    @grupos = Grupo.order(:nome).where(:usuario_id => current_usuario)
    @restaurante = Restaurante.new
  end

  def associarRestaurante
    @restaurante = Restaurante.find(params[:restaurante][:id])
    @grupo = Grupo.where(:usuario_id => current_usuario).find(params[:grupo_id])
    if @grupo.restaurantes.include? @restaurante
      redirect_to(@grupo, :alert => 'Restaurante já está associado ao grupo.')
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
      redirect_to(grupos_path, :alert => 'Usuário já está associado ao grupo.')
    else
      @grupo.usuarios << @usuario
      @grupo.save
      redirect_to(grupos_path, :notice => 'Seu pedido de associação foi realizado. Basta esperar que o proprietário desse Grupo autorize sua participação')
    end
  end

  def desassociarUsuario
    @usuario = current_usuario
    @grupo = Grupo.find(params[:grupo_id])
    if @grupo.usuarios.include? @usuario
      @grupo.usuarios.delete @usuario
      redirect_to(grupos_path, :notice => 'Usuário foi desasociado do grupo com sucesso.')
    else
      redirect_to(grupos_path, :alert => 'Usuário não estava associado ao grupo.')
    end
  end

  def listarUsuarios
    @usuario = current_usuario
    @grupo = Grupo.find(params[:grupo_id])
    if @usuario != @grupo.usuario
      redirect_to(grupos_path, :alert => 'Você não é proprietário desse grupo.')
    elsif @grupo.usuarios.count == 0
      #flash[:alert] = 'Esse grupo ainda não possui nenhum membro.'
      redirect_to(grupos_path, :alert => 'Esse grupo ainda não possui nenhum membro.')
    else
      render :action => "usuarios"
    end
  end
end
