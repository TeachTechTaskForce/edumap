class AddGradeToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :grade, :string
    remove_column :levels, :age
  end
end
