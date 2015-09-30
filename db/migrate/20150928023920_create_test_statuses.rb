class CreateTestStatuses < ActiveRecord::Migration
  def change
    create_table :test_statuses do |t|
      t.boolean :result
      t.references :content_test, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
