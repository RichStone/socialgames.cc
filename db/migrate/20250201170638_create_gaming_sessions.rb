class CreateGamingSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :gaming_sessions do |t|
      t.references :team, null: false, foreign_key: true
      t.datetime :finished_at
      t.text :note
      t.boolean :with_cheating, default: false

      t.timestamps
    end
  end
end
