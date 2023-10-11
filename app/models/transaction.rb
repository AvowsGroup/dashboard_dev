class Transaction < ApplicationRecord
  belongs_to :job_type, foreign_key: 'fw_job_type_id'
  belongs_to :xray_review, foreign_key: 'xray_review_id'
  belongs_to :pcr_review, foreign_key: 'pcr_review_id'
  has_many :xray_pending_decision,class_name: "XrayPendingDecision"
  # belongs_to :xray_pending_review, foreign_key: 'xray_pending_review_id'
  belongs_to :country, class_name: 'Country', foreign_key: 'fw_country_id'
  belongs_to :organization, class_name: 'Organization', foreign_key: 'organization_id'
  belongs_to :doctor, class_name: 'Doctor', foreign_key: 'doctor_id'
  has_many :medical_appeals,class_name: 'MedicalAppeal'
  has_one :xqcc_pool, foreign_key: 'transaction_id'
  has_one :pcr_pool
  has_many :myimms_transactions
  belongs_to :foreign_worker,class_name: "ForeignWorker",foreign_key: "foreign_worker_id"
  has_many :xray_pending_review,class_name: "XrayPendingReview"
belongs_to :laboratory_examination, foreign_key: 'id'
 belongs_to :xray_examination, foreign_key: 'id'
 belongs_to :xray_facility, foreign_key: 'xray_facility_id'
 belongs_to :transaction_result_update, foreign_key: 'id'
  enum registration_type: { new_registration: 0, renewal: 1}
  # Define a method to retrieve transaction data for the last 5 years
 def self.transaction_data_last_5_years
    # Get the current year
    current_year = Time.now.year

    # Initialize a hash to store the data
    transaction_data_by_year = {}

    # Loop through the last 5 years
    (current_year - 4..current_year).each do |year|
      # Initialize a hash to store transaction counts for each month of the current year
      transactions_by_month = Hash.new(0)

      # Query the database to get transactions for the current year
      transactions = Transaction.where("EXTRACT(YEAR FROM created_at) = ?", year)

      # Loop through the transactions and organize the data by month
      transactions.each do |transaction|
        month = transaction.created_at.month
        transactions_by_month[month] += 1
      end

      # Create an array to store transaction counts for each month
      transaction_counts_per_month = (1..12).map { |month| transactions_by_month[month] }

      # Store the data in the hash
      transaction_data_by_year[year] = transaction_counts_per_month
    end

    # Return the transaction data as a hash
    transaction_data_by_year
  end
end 


  # # Define a method to retrieve transaction data for the last 5 years
  # def self.transaction_data_last_5_years (trans = Transaction.all)
  #   data = trans.group("DATE_TRUNC('month', created_at)").count.map { |date, count| [date.strftime('%B %Y'), count] }

  #   grouped_data = {}

  #   # Iterate through the data and group it by year
  #   data.each do |month_str, count|
  #     # Extract the year from the month string
  #     year = month_str.split(' ')[1].to_i

  #     # Create a new array if the year is not in the hash
  #     grouped_data[year] ||= []

  #     # Add the [month, count] pair to the array for the corresponding year
  #     grouped_data[year] << [count]
  #   end

  #   grouped_data.transform_values { |value| value.flatten }
  # end 