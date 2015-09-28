class CreateContentTests < ActiveRecord::Migration
  def change
    create_table :content_tests do |t|
      t.string :comparison
      t.string :content
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
