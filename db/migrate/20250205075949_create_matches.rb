class CreateMatches < ActiveRecord::Migration[7.2]
  def change
    create_table :matches do |t|
      t.references :gaming_session, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
