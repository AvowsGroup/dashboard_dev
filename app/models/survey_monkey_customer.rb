class SurveyMonkeyCustomer < ApplicationRecord
	 def self.transaction_data_1_year
    # Get the current year
    current_year = Date.today.year

    # Initialize a hash to store the data
    transaction_data_by_year = {}

    # Loop through the last 5 years
     #current_year.each do |year|
      # Initialize a hash to store transaction counts for each month of the current year
      transactions_by_month = Hash.new(0)

      # Query the database to get transactions for the current year
      transactions = SurveyMonkeyCustomer.where("EXTRACT(YEAR FROM start_date) = ?", current_year)

      # Loop through the transactions and organize the data by month
      transactions.each do |transaction|
        month = transaction.start_date.month
        transactions_by_month[month] += 1
      end

      # Create an array to store transaction counts for each month
      transaction_counts_per_month = (1..12).map { |month| transactions_by_month[month] }

      # Store the data in the hash
      transaction_data_by_year[current_year] = transaction_counts_per_month
    

    # Return the transaction data as a hash
    transaction_data_by_year
  end
end
