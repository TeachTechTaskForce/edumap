class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :name
      t.references :proficiency, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
