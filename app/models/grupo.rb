class Grupo < ActiveRecord::Base
  has_and_belongs_to_many :usuarios
  has_and_belongs_to_many :restaurantes
  belongs_to :usuario # Dono do grupo

  validates_presence_of :nome, :usuario_id

  #validate :verificar_propietario

  def verificar_propietario
    if usuario_id != current_usuario.id
      errors << "Somente o dono pode modificar o grupo."
    end
  end
end
