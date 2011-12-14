class CreateRestaurantes < ActiveRecord::Migration
  def self.up
    create_table :restaurantes do |t|
      t.string :nome
      t.references :usuario # Dono do restaurante

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurantes
  end
end
