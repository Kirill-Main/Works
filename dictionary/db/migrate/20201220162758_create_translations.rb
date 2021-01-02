# frozen_string_literal: true

class CreateTranslations < ActiveRecord::Migration[6.0]
  def change
    create_table :translations do |t|
      t.string :str_from
      t.string :str_to
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
