class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string :code
      t.string :name
      t.string :long_name
      t.time :created_at
      t.time :updated_at
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
