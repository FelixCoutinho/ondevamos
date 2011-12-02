class UsuariosController < ApplicationController

  Thread.current[:current_usuario] = @current_usuario
end
