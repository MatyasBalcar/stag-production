class AddLengthToLectures < ActiveRecord::Migration[7.1]
  def change
    add_column :lectures, :length, :integer
  end
end
