class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :country
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
