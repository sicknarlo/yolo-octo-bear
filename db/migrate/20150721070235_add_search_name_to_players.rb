class AddSearchNameToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :search_name, :string
  end
end
