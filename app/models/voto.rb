class Voto < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :restaurante
  belongs_to :grupo

  validates_presence_of :data, :grupo_id, :usuario_id, :restaurante_id

  def jaVotou(usuario, grupo)
    Voto.where("usuario_id = ?", usuario.id).where("data >= ?", grupo.inicio).where("grupo_id = ?", grupo).exists?
  end

  def contagemVotacao(grupo, data = Date.today)
    Voto.find(
      :all,
      :select => "restaurantes.nome as label, count(*) as total",
      :conditions => {:data => data, :grupo_id => grupo},
      :joins => "inner join restaurantes on restaurantes.id = votos.restaurante_id",
      :group => [:nome, 'votos.grupo_id'])
  end
end
