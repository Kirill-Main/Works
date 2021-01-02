# frozen_string_literal: true

class AddIsHiddenToTransaltions < ActiveRecord::Migration[6.0]
  def change
    add_column :translations, :is_hidden, :boolean, default: false
  end
end
