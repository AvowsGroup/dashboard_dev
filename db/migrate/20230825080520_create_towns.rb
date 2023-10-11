class CreateTowns < ActiveRecord::Migration[5.2]
  def change
    create_table :towns do |t|
      t.string :code
      t.string :name
      t.references :state, foreign_key: true
      t.time :created_at
      t.time :updated_at
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
