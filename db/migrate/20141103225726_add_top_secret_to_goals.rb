class AddTopSecretToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :top_secret, :boolean, null: false
  end
end
