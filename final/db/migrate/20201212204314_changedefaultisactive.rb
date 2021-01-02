# frozen_string_literal: true

class Changedefaultisactive < ActiveRecord::Migration[6.0]
  def change
    change_column :middles, :is_active, :boolean, default: false
  end
end
