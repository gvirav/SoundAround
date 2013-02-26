class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name
      t.string :spotify_link

      t.timestamps
    end
  end
end
