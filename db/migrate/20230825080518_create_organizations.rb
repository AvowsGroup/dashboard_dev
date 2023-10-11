class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.integer :parent_id
      t.string :code
      t.string :name
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :address4
      t.integer :state_id
      t.integer :town_id
      t.string :postcode
      t.string :phone
      t.string :fax
      t.string :email
      t.string :org_type
      t.string :bank_code
      t.string :bank_co
      t.string :bank_acctno
      t.time :created_at
      t.time :updated_at
      t.integer :created_by
      t.integer :updated_by
      t.integer :zone_id
      t.string :status

      t.timestamps
    end
  end
end
