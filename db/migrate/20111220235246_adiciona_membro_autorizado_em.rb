class AdicionaMembroAutorizadoEm < ActiveRecord::Migration
  def self.up
    change_table :grupos_usuarios do |t|
      t.datetime :autorizado_em
    end
  end

  def self.down
  end
end
