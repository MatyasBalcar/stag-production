class AddIsCheckedToLectures < ActiveRecord::Migration[7.1]
  def change
    add_column :lectures, :is_checked, :boolean, default: true
  end
end
