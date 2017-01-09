class CreateEpisodes < ActiveRecord::Migration[5.0]
  def change
    create_table :episodes do |t|
      t.integer :user_id
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.integer :intensity
      t.jsonb :symptoms, null: false, default: "{}"
      t.jsonb :triggers, null: false, default: "{}"
      t.timestamps
    end
  end
end
