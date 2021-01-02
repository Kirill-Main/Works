# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :main, presence: true, length: { maximum: 200 }
end
