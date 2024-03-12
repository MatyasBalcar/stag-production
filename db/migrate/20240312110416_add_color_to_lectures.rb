class AddColorToLectures < ActiveRecord::Migration[7.1]
  def change
    add_column :lectures, :color, :string
  end
end
