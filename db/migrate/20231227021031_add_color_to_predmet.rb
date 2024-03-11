class AddColorToPredmet < ActiveRecord::Migration[7.1]
  def change
    add_column :predmets, :color, :string
  end
end
