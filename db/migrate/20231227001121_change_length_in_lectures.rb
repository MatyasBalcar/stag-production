class ChangeLengthInLectures < ActiveRecord::Migration[7.1]
  def change
    remove_column :lectures, :length
    add_column :lectures, :length, :float
  end
end
