class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :latitude
      t.string :longitude
      t.string :uid

      t.timestamps
    end
  end
end
