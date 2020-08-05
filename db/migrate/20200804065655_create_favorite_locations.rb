class CreateFavoriteLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_locations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :location_id

      t.timestamps
    end
  end
end
