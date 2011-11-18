class Voto < ActiveRecord::Base
  has_one :usuario
  has_one :restaurante

  validates_associated :usuario, :restaurante

  validates_presence_of :data, :usuario_id, :restaurante_id
  
  def jaVotou(usuario, data = Date.today)
    Voto.where(:usuario_id => usuario.id, :data => data).exists?
  end
  
  def contagemVotacao(data = Date.today)
    Voto.find(
      :all, 
      :select => "restaurantes.nome as label, count(*) as total",
      :conditions => {:data => data},
      :joins => "inner join restaurantes on restaurantes.id = votos.restaurante_id",
      :group => :restaurante_id)
  end
end

