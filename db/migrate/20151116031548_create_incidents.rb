class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.references :site
      t.datetime :cleared_at

      t.timestamps null: false
    end
  end
end
