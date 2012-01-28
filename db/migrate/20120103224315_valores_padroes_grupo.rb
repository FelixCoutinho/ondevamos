class ValoresPadroesGrupo < ActiveRecord::Migration
  def self.up
    Grupo.update_all ["frequencia = ? ,inicio = created_at, a_cada = ?", 1, 1]
  end

  def self.down
  end
end
