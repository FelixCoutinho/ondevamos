class Grupo < ActiveRecord::Base
  has_many :usuarios
  has_many :restaurantes
  belongs_to :usuario # Dono do grupo

  validates_presence_of :nome, :usuario_id
end
