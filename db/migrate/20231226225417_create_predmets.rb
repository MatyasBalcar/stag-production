class CreatePredmets < ActiveRecord::Migration[7.1]
  def change
    create_table :predmets do |t|

      t.timestamps
    end
  end
end
