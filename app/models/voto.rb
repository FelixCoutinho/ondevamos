class Voto < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :restaurante
  belongs_to :grupo

  validates_presence_of :data, :grupo_id, :usuario_id, :restaurante_id

  def jaVotou(usuario, grupo)
    if grupo.frequencia == 1 # Diária
      Voto.where("usuario_id = ?", usuario.id).where("data = ?", Date.today).where("grupo_id = ?", grupo).exists?
    elsif grupo.frequencia == 2 # Diária (Dias Úteis)
      if (1..5).include? Date.today.wday
        Voto.where("usuario_id = ?", usuario.id).where("data = ?", Date.today).where("grupo_id = ?", grupo).exists?
      else
        true
      end
    elsif grupo.frequencia == 3 # Semanal
      Voto.joins(:grupo)
        .where(:usuario_id => usuario.id)
        .where(:grupo_id => grupo.id)
        .where("votos.updated_at between grupos.final_ultima_votacao and ?",
          grupo.final_ultima_votacao + eval(grupo.a_cada.to_s+".week"))
        .exists?
    elsif grupo.frequencia == 4 # Mensal
      Voto.joins(:grupo)
        .where(:usuario_id => usuario.id)
        .where(:grupo_id => grupo.id)
        .where("votos.updated_at between grupos.final_ultima_votacao and ?",
          grupo.final_ultima_votacao + eval(grupo.a_cada.to_s+".months"))
        .exists?
    elsif grupo.frequencia == 5 # Anual
      Voto.joins(:grupo)
        .where(:usuario_id => usuario.id)
        .where(:grupo_id => grupo.id)
        .where("votos.updated_at between grupos.final_ultima_votacao and ?",
          grupo.final_ultima_votacao + eval(grupo.a_cada.to_s+".years"))
        .exists?
    end
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
