# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  validates :title, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :summary, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :main, presence: true, length: { maximum: 200 }, uniqueness: true
end
