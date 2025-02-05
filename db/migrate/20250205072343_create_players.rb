class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players do |t|
      t.references :team, null: false, foreign_key: true
      t.string :username

      t.timestamps
    end
  end
end
