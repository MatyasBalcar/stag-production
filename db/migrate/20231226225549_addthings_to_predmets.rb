class AddthingsToPredmets < ActiveRecord::Migration[7.1]
  def change
    add_column :predmets, :name, :string
    add_column :predmets, :adbreviation, :text
    add_column :predmets, :status, :text
    add_column :predmets, :teacher, :text
  end
end
