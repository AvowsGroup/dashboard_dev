class XqccPool < ApplicationRecord
  belongs_to :fw_transaction, foreign_key: 'transaction_id', primary_key: 'id',class_name: "Transaction"
end
