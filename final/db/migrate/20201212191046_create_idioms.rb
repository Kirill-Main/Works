# frozen_string_literal: true

class CreateIdioms < ActiveRecord::Migration[6.0]
  def change
    create_table :idioms do |t|
      t.string :str_from
      t.string :language_from
      t.string :str_to
      t.string :language_to

      t.timestamps
    end
  end
end
