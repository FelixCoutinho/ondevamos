# encoding: UTF-8
class UsuariosController < ApplicationController
  def new
    @usuario = Usuario.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @usuario = Usuario.new(params[:usuario])

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to(votos_url, :notice => 'Usuário foi críado com sucesso. ') }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
