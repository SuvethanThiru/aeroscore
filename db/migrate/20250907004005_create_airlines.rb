# db/migrate/20241201000001_create_airlines.rb
class CreateAirlines < ActiveRecord::Migration[7.0]
  def change
    create_table :airlines do |t|
      t.string :name, null: false
      t.text :image_url
      t.text :description
      t.timestamps
    end
    
    add_index :airlines, :name, unique: true
  end
end