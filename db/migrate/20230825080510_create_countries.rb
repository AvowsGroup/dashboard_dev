class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :old_code
      t.string :code
      t.string :name
      t.timestamp :created_at
      t.timestamp :updated_at
      t.string :created_by
      t.string :updated_by

      t.timestamps
    end
  end
end
