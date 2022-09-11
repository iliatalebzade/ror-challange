class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.string :body
      t.string :tags, array: true
      t.references :user, null: false, foreign_key: true
      t.integer :answer_count, default: 0

      t.timestamps
    end
  end
end
