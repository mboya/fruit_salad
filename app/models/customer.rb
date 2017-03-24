class Customer < ApplicationRecord
  validates :external_id, presence: true
end
