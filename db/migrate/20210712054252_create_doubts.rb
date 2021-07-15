class CreateDoubts < ActiveRecord::Migration[6.1]
  def change
    create_table :doubts do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.integer :state, default: 0, index: true
      t.timestamps
    end
  end
end
