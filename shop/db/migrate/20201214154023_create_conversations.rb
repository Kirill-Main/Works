# frozen_string_literal: true

class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :quesstion
      t.string :answer

      t.timestamps
    end
  end
end
