class AdicionarACadaFrequenciaGrupo < ActiveRecord::Migration
  def self.up
    change_table :grupos do |t|
      t.integer :a_cada
    end
  end

  def self.down
  end
end
