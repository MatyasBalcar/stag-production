class ChangeLEctures < ActiveRecord::Migration[7.1]
 
    def change
      remove_column :lectures, :predmet_name
      add_column :lectures, :day, :string
    end
  

end
