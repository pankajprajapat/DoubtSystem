class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :doubt, index: true, foreign_key: true
      t.integer :state, default: 0
      t.text :description
      t.timestamps
    end
  end
end
