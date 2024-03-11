class AddIsStackedToLectures < ActiveRecord::Migration[7.1]
  def change
    add_column :lectures, :is_stacked, :boolean, default: false
  end
end
