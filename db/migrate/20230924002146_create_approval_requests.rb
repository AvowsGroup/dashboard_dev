class CreateApprovalRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :approval_requests do |t|
      t.integer :request_user_id
      t.integer :respond_user_id
      t.integer :state
      t.datetime :requested_at
      t.datetime :cancelled_at
      t.datetime :approved_at
      t.datetime :rejected_at
      t.datetime :executed_at
      t.boolean :is_draft
      t.string :category
      t.string :approval_decision
      t.integer :approval_user_id
      t.datetime :approval_at
      t.string :approval2_decision
      t.integer :approval2_user_id
      t.datetime :approval2_at
      t.json :additional_information

      t.timestamps
    end
  end
end
