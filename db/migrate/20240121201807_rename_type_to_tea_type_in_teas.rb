class RenameTypeToTeaTypeInTeas < ActiveRecord::Migration[7.1]
  def change
    rename_column :teas, :type, :tea_type
  end
end
