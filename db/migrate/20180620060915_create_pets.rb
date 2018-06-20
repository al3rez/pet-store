class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name, unique: true
      t.integer :pet_type
      t.belongs_to :user

      t.timestamps
    end
  end
end
