class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :doubt, index: true, foreign_key: true
      t.text :description
      t.timestamps
    end
  end
end
