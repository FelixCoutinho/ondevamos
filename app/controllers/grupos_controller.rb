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
    @grupo.inicio = DateTime.now
    @frequencias = Grupo::Frequencias
  end

  def create
    @grupo = Grupo.new(params[:grupo])
    @grupo.usuario_id = current_usuario.id
    @frequencias = Grupo::Frequencias
    if @grupo.save
      redirect_to(grupos_url, :notice => 'Grupo foi adicionado com sucesso')
    else
      render :action => "new"
    end
  end

  def update
    @grupo = Grupo.where(:usuario_id => current_usuario).find(params[:id])
    @frequencias = Grupo::Frequencias
    if @grupo.update_attributes(params[:grupo])
      redirect_to(grupos_url, :notice => 'Grupo foi atualizado')
    else
      render :action => "edit"
    end
  end

  def destroy
    @grupo = Grupo.where(:usuario_id => current_usuario).find(params[:id])
    @grupo.destroy

    redirect_to(grupos_url, :notice => 'Grupo foi removido')
  end

  def edit
    @grupo = Grupo.where(:usuario_id => current_usuario).find(params[:id])
    @frequencias = Grupo::Frequencias
  end

  def show
    if params[:id].nil?
      @grupos = Grupo.order(:nome).where(:usuario_id => current_usuario)
    else
      @grupos = Grupo.order(:nome).where(:usuario_id => current_usuario).where(:id => params[:id])
    end
    @restaurante = Restaurante.new
  end

  def associarRestaurante
    @restaurante = Restaurante.find(params[:restaurante][:id])
    @grupo = Grupo.where(:usuario_id => current_usuario).find(params[:grupo_id])
    if @grupo.restaurantes.include? @restaurante
      redirect_to(@grupo, :alert => 'Restaurante já está associado ao grupo')
    else
      @grupo.restaurantes << @restaurante
      @grupo.save
      redirect_to(@grupo, :notice => 'Restaurante foi associado ao grupo')
    end
  end

  def desassociarRestaurante
    @grupo = Grupo.where(:usuario_id => current_usuario).find(params[:grupo_id])
    @restaurante = Restaurante.find(params[:id])
    @grupo.restaurantes.delete @restaurante
    redirect_to(@grupo, :notice => 'Restaurante foi desassociado do grupo')
  end

  def associarUsuario
    @usuario = current_usuario
    @grupo = Grupo.find(params[:grupo_id])
    if @grupo.usuarios.include? @usuario
      redirect_to(grupos_path, :alert => 'Usuário já está associado ao grupo')
    else
      @grupo.usuarios << @usuario
      @grupo.save
      @membro = Membro.where(:grupo_id => @grupo, :usuario_id => @usuario).first
      autorizacao = Mensageiro.autorizacao(@membro)
      autorizacao.deliver
      redirect_to(grupos_path, :notice => 'Seu pedido de associação foi realizado')
    end
  end

  def desassociarUsuario
    @usuario = current_usuario
    @grupo = Grupo.find(params[:grupo_id])
    if @grupo.usuarios.include? @usuario
      @grupo.usuarios.delete @usuario
      redirect_to(grupos_path, :notice => 'Usuário foi desasociado do grupo')
    else
      redirect_to(grupos_path, :alert => 'Usuário não estava associado ao grupo')
    end
  end

  def listarUsuarios
    @usuario = current_usuario
    @grupo = Grupo.find(params[:grupo_id])
    if @usuario != @grupo.usuario
      redirect_to(grupos_path, :alert => 'Você não é proprietário desse grupo')
    elsif @grupo.membros.count == 0
      redirect_to(grupos_path, :alert => 'Esse grupo ainda não possui nenhum membro')
    else
      render :action => "usuarios"
    end
  end

  def autorizarMembro
    @usuario = current_usuario
    @membro = Membro.find(params[:membro_id])
    if @usuario != @membro.grupo.usuario
      redirect_to('/grupos/usuarios/'+@membro.grupo.id.to_s, :alert => 'Você não é proprietário desse grupo')
    elsif @membro.autorizado_em?
      redirect_to('/grupos/usuarios/'+@membro.grupo.id.to_s, :alert => 'Esse usuário já está autorizado')
    else
      @membro.autorizado_em = DateTime.now
      if @membro.save
        autorizacao = Mensageiro.autorizado(@membro)
        autorizacao.deliver
        redirect_to('/grupos/usuarios/'+@membro.grupo.id.to_s, :notice => 'O usuário foi autorizado')
      end
    end
  end

  def desautorizarMembro
    @usuario = current_usuario
    @membro = Membro.find(params[:membro_id])
    if @usuario != @membro.grupo.usuario
      redirect_to('/grupos/usuarios/'+@membro.grupo.id.to_s, :alert => 'Você não é proprietário desse grupo')
    elsif @membro.autorizado_em.nil?
      redirect_to('/grupos/usuarios/'+@membro.grupo.id.to_s, :alert => 'Esse usuário já está desautorizado')
    else
      @membro.autorizado_em = nil
      if @membro.save
        redirect_to('/grupos/usuarios/'+@membro.grupo.id.to_s, :notice => 'O usuário foi desautorizado')
      end
    end
  end
end
