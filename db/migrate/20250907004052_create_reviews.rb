# db/migrate/20241201000002_create_reviews.rb
class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :score, null: false
      t.references :airline, null: false, foreign_key: true
      t.timestamps
    end
    
    add_index :reviews, [:airline_id, :created_at]
    add_index :reviews, :score
  end
end