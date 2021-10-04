class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.float :kcal
      t.float :protein
      t.float :fat
      t.float :carbo
      t.date :meal_date
      t.string :meal_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
