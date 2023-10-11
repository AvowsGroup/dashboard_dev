class CreateAgencies < ActiveRecord::Migration[5.2]
  def change
    create_table :agencies do |t|
      t.references :organization, foreign_key: true
      t.integer :agency_license_category
      t.string :license_number
      t.datetime :license_expired_at
      t.string :director_name
      t.string :director_ic_number
      t.string :pic_name
      t.string :pic_ic_number
      t.string :pic_phone
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :address4
      t.integer :country_id
      t.integer :state_id
      t.integer :town_id
      t.string :postcode
      t.string :phone
      t.string :email
      t.boolean :personal_data_consent
      t.string :status
      t.string :registration_comment
      t.datetime :registration_approved_at
      t.string :registration_approval_by
      t.datetime :activated_at
      t.string :approval_status
      t.string :approval_remark
      t.integer :bank_payment_id
      t.integer :bank_id
      t.string :bank_account_number
      t.datetime :expired_at
      t.boolean :renewal_order_created
      t.boolean :problematic
      t.boolean :document_verified
      t.boolean :agreement_accepted
      t.boolean :sop_acknowledge

      t.timestamps
    end
  end
end
