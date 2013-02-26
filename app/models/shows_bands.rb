class ShowsBands < ActiveRecord::Base
	self.table_name = 'shows_bands'
  attr_accessible :band_id, :show_id

  belongs_to :show
  belongs_to :band

  # validates :bar_id, :uniqueness => {:scope => :game_id}
end
