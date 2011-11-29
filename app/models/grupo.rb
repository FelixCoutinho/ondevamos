class Grupo < ActiveRecord::Base
  has_and_belongs_to_many :usuarios
  has_and_belongs_to_many :restaurantes
  has_one :usuario # Dono do grupo

  validates_presence_of :nome, :usuario_id
end
