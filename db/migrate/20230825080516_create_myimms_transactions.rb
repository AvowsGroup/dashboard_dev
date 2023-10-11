class CreateMyimmsTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :myimms_transactions do |t|
      t.integer :transaction_id
      t.integer :status
      t.timestamp :created_at
      t.timestamp :updated_at
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
