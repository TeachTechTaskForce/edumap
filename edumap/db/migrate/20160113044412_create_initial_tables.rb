class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :standards do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :lessons do |t|
      t.string :name
      t.string :lesson_url
      t.timestamps null: false
    end

    create_table :curriculums do |t|
      t.string :name
      t.string :curriculum_url
      t.timestamps null: false
    end

    create_table :levels do |t|
      t.integer :age
      t.timestamps null: false
    end

    create_table :codes_lessons, id: false do |t|
      t.belongs_to :codes, index: true
      t.belongs_to :lessons, index: true
    end

    create_table :lessons_levels, id: false do |t|
      t.belongs_to :lessons, index: true
      t.belongs_to :levels, index: true
    end

    add_reference :codes, :standards, index: true
    add_reference :lessons, :curriculums, index: true

  end
end
