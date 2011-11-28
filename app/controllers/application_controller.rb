class ApplicationController < ActionController::Base
  protect_from_forgery

  # Executa a configuração do 'locale' da aplicação antes de qualquer filtro
  before_filter :set_locale

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
end

