# frozen_string_literal: true

class Idiom < ApplicationRecord
  has_one :middle
  validates :str_from, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :str_to, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :language_from, presence: true
  validates :language_to, presence: true
end
