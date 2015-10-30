class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.references :curriculum, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
