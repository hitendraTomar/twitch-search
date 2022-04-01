# frozen_string_literal: true

# CreateSearchHistories
class CreateSearchHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :search_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :query
      t.json :results
      t.string :stream_user_login
      t.timestamps
    end
  end
end
