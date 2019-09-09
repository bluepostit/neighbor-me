class CreateTools < ActiveRecord::Migration[5.2]
  def change
    create_table :tools do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.text :description, null: false
      t.string :photo

      t.timestamps
    end
  end
end
