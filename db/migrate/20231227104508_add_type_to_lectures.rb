class AddTypeToLectures < ActiveRecord::Migration[7.1]
  def change
    add_column :lectures, :type, :string
  end
end
