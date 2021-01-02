# frozen_string_literal: true

class AddReference < ActiveRecord::Migration[6.0]
  def change
    add_reference :conversations, :product
  end
end
