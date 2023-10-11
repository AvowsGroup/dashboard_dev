class CreateConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :conditions do |t|
      t.string :code
      t.text :description
      t.string :exam_type
      t.string :field_type
      t.string :category
      t.bigint :created_by
      t.bigint :updated_by
      t.datetime :deleted_at
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
    add_index :conditions, :deleted_at
    add_index :conditions, :created_at
    add_index :conditions, :updated_at
  end
end
