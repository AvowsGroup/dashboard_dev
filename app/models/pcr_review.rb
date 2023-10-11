class PcrReview < ApplicationRecord
  has_one :pcr_pool
  has_many :fw_transactions,class_name: "Transaction"
end
