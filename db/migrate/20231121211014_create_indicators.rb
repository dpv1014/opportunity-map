class CreateIndicators < ActiveRecord::Migration[7.0]
  def change
    create_table :indicators do |t|
      t.string :name
      t.text :description
      t.decimal :target_value
      t.integer :indicator_type
      t.decimal :base_linea

      t.timestamps
    end
  end
end
