class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true
      t.text :description
      t.text :ingredients
      t.text :instructions

      t.timestamps
    end
  end
end
