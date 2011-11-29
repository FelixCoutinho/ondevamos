class GruposRestaurantes < ActiveRecord::Migration
  def self.up
    create_table :grupos_restaurantes, :id => false do |t|
      t.references :grupo, :restaurante
    end
  end

  def self.down
    drop_table :grupos_restaurantes
  end
end
