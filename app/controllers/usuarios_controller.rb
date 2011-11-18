# encoding: UTF-8
class UsuariosController < ApplicationController
  def new
    @usuario = Usuario.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def create
    @usuario = Usuario.new(params[:usuario])

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to(usuarios_url, :notice => 'Usuário foi críado com sucesso.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        format.html { redirect_to(usuarios_url, :notice => 'Usuário foi atualizado com sucesso.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to(usuarios_url, :notice => 'Usuário foi removido com sucesso.') }
    end
  end
end
