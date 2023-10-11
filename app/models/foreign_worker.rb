class ForeignWorker < ApplicationRecord
  has_many :fw_transactions,class_name: "Transaction"
  has_many :insurance_purchases
end
