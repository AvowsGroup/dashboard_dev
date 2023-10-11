class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :encrypted_password
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer :sign_in_count
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet :current_sign_in_ip
      t.inet :last_sign_in_ip
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email
      t.integer :failed_attempts
      t.string :unlock_token
      t.datetime :locked_at
      t.string :code
      t.string :username
      t.string :name
      t.string :status
      t.string :activation_token
      t.string :userable_type
      t.bigint :userable_id
      t.bigint :employer_supplement_id
      t.bigint :title_id
      t.bigint :created_by
      t.bigint :updated_by
      t.datetime :deleted_at
      t.datetime :password_changed_at
      t.string :unique_session_id, limit: 20
      t.boolean{default :session_limitable_disabled
      t.string :false}
      t.bigint :role_id
      t.string :designation
      t.text :comment

      t.timestamps
    end
  end
end
