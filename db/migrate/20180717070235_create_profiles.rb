class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surname
      t.date :birth_date
      t.text :mini_bio
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
