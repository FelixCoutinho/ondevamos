class CreateVotos < ActiveRecord::Migration
  def self.up
    create_table :votos do |t|
      t.references :restaurante
      t.references :usuario
      t.date :data
      t.references :grupo

      t.timestamps
    end
  end

  def self.down
    drop_table :votos
  end
end
