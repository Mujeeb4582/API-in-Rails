class CreateTrails < ActiveRecord::Migration[7.0]
  def change
    create_table :trails do |t|
      t.string :name
      t.integer :miles

      t.references :forest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
