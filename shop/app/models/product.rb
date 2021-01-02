# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user
  has_many :conversation
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :main, presence: true, length: { maximum: 200 }, uniqueness: true
end
