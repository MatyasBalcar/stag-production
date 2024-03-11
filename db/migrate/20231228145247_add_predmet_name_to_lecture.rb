class AddPredmetNameToLecture < ActiveRecord::Migration[7.1]
  def change
    add_column :lectures, :predmet_name, :string
  end
end
