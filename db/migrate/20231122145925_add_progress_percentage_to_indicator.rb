class AddProgressPercentageToIndicator < ActiveRecord::Migration[7.0]
  def change
    add_column :indicators, :progress_percentage, :decimal
  end
end
