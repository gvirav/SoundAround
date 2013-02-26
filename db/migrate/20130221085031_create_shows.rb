class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.datetime :date_time
      t.string :price
      t.string :ticket_link

      t.timestamps
    end
  end
end
