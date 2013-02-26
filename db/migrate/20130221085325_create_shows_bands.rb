class CreateShowsBands < ActiveRecord::Migration
  def change
    create_table :shows_bands do |t|
      t.integer :band_id
      t.integer :show_id

      t.timestamps
    end
  end
end
