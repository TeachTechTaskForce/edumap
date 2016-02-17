class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :identifier
      t.string :description
      t.timestamps null: false
    end

    create_table :standards do |t|
      t.string :name
      t.string :abbreviation
      t.timestamps null: false
    end

    create_table :lessons do |t|
      t.string :name
      t.string :lesson_url
      t.string :time
      t.text :description
      t.boolean :plugged?, default: true
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
      t.belongs_to :code, index: true
      t.belongs_to :lesson, index: true
    end

    create_table :lessons_levels, id: false do |t|
      t.belongs_to :lesson, index: true
      t.belongs_to :level, index: true
    end

    create_table :lessons_standards, id: false do |t|
      t.belongs_to :lesson, index: true
      t.belongs_to :standard, index: true
    end

    add_reference :codes, :standard, index: true
    add_reference :lessons, :curriculum, index: true

  end
end
