class CreateIndicatorTrackings < ActiveRecord::Migration[7.0]
  def change
    create_table :indicator_trackings do |t|
      t.date :report_date
      t.decimal :value
      t.references :indicator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
