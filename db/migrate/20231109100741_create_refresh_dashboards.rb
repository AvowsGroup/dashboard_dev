class CreateRefreshDashboards < ActiveRecord::Migration[6.0]
  def change
    create_table :refresh_dashboards do |t|
      t.integer :geographical, default: 5 * 60 * 1000 # 5 minutes in milliseconds
      t.integer :fw_information, default: 5 * 60 * 1000
      t.integer :customer_satisfaction, default: 5 * 60 * 1000
      t.integer :dep_information, default: 5 * 60 * 1000
      t.integer :service_provider, default: 5 * 60 * 1000
      t.string :created_by
      t.string :modified_by
      t.timestamps
    end
  end
end
