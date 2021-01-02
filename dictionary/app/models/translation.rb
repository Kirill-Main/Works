# frozen_string_literal: true

class Translation < ApplicationRecord
  belongs_to :user
  validates :str_from, presence: true, length: { maximum: 50 }
  validates :str_to, presence: true, length: { maximum: 50 }
end
