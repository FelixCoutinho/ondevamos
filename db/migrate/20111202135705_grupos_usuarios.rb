class GruposUsuarios < ActiveRecord::Migration
  def self.up
    create_table :grupos_usuarios, {:id => false} do |t|
      t.references :usuario
      t.references :grupo
    end
  end

  def self.down
    drop_table :grupos_usuarios
  end
end
