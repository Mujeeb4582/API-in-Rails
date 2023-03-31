class CreateForests < ActiveRecord::Migration[7.0]
  def change
    create_table :forests do |t|
      t.string :name
      t.string :state

      t.timestamps
    end
  end
end
