class ChavePrimariaGruposUsuarios < ActiveRecord::Migration
  def self.up
    change_table :grupos_usuarios do |t|
      t.column :id, :primary_key
    end
  end

  def self.down
  end
end
