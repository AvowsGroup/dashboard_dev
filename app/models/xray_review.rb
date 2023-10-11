class XrayReview < ApplicationRecord
  has_many :fw_transactions,class_name: "Transaction"
end

 