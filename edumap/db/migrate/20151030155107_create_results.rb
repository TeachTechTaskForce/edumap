class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :lesson, index: true, foreign_key: true
      t.references :code, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
