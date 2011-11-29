class CreateGrupos < ActiveRecord::Migration
  def self.up
    create_table :grupos do |t|
      t.string :nome
      t.references :usuario # Dono do grupo

      t.timestamps
    end
  end

  def self.down
    drop_table :grupos
  end
end
