class AddWeightDateToWeights < ActiveRecord::Migration[6.1]
  def change
    add_column :weights, :weight_date, :date
  end
end
