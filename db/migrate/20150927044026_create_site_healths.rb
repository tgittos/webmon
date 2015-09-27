class CreateSiteHealths < ActiveRecord::Migration
  def change
    create_table :site_healths do |t|
      t.references :site, index: true, foreign_key: true
      t.integer :http_response
      t.integer :response_time

      t.timestamps null: false
    end
  end
end
