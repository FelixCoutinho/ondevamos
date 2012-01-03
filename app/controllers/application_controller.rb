# encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  # Executa a configuração do 'locale' da aplicação antes de qualquer filtro
  before_filter :set_locale

  # Configuração da Zona de Hora da aplicação
  before_filter :set_timezone

  # Definindo o locale
  def set_locale
    I18n.locale = 'pt-BR' # Português do Brasil
  end

  def resource_name
    :usuario
  end

  def resource
    @resource ||= Usuario.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:usuario]
  end

  def set_timezone
    #if !current_usuario.time_zone.nil?
    #  Time.zone = current_usuario.time_zone
    #end
  end

end
