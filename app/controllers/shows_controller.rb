require 'noisepop_scrape'
class ShowsController < ApplicationController
	def index
		@scraper = NoisePopScraper.new
		@shows = @scraper.scrape_and_clean			
	end
end
