class CreateAlmocos < ActiveRecord::Migration
  def self.up
    create_table :almocos do |t|
      t.date :data

      t.timestamps
    end
  end

  def self.down
    drop_table :almocos
  end
end
