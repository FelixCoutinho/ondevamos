class Voto < ActiveRecord::Base
  has_one :usuario
  has_one :restaurante

  validates_associated :usuario, :restaurante

  validates_presence_of :data
  
  def jaVotou(usuario, data = Date.today)
    Voto.where(:usuario_id => usuario.id, :data => data).exists?
  end
end

