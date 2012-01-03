class AdicionarFinalVotacaoGrupo < ActiveRecord::Migration
  def self.up
    change_table :grupos do |t|
      t.datetime :final_ultima_votacao, :null => false, :default => DateTime.now
    end
  end

  def self.down
  end
end
