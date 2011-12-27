class AdicionarFrequenciaGrupo < ActiveRecord::Migration
  def self.up
    change_table :grupos do |t|
      t.integer :frequencia
      t.datetime :inicio
    end
  end

  def self.down
  end
end
