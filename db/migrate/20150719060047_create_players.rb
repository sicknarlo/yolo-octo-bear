class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.integer :age
      t.integer :rank
      t.integer :adp
      t.integer :value

      t.timestamps null: false
    end
  end
end
