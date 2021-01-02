# frozen_string_literal: true

class CreateMiddles < ActiveRecord::Migration[6.0]
  def change
    create_table :middles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :idiom, null: false, foreign_key: true
      t.boolean :is_active

      t.timestamps
    end
  end
end
