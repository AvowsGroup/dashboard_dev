class InsurancePurchase < ApplicationRecord
  belongs_to :foreign_worker,class_name: "ForeignWorker",foreign_key: "foreign_worker_id"
end
