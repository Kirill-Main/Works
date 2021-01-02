# frozen_string_literal: true

class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :product
end
