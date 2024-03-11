class ChangeType < ActiveRecord::Migration[7.1]
  def change
    remove_column :lectures, :type
    add_column :lectures, :lecture_type, :string
  end
end
