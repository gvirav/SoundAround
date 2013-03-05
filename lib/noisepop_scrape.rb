require 'nokogiri'
require 'open-uri'
require 'csv'

class NoisePopScraper

  attr_accessor :lineups, :shows

  def initialize
    @url = "http://schedule.noisepop.com/"    
    @noisepop = noko_me(@url)
    @lineups = []
    @shows = []
  end

  def noko_me(url)
    Nokogiri::HTML(open(url))
  end

  def scrape_and_clean    
    scrape_lineups
    scrape_shows
    to_hash
  end  

  def scrape_lineups
    @noisepop.css('ul li div h2 a').each do |data|
      @lineups << data.text.strip
      @lineups.each { |x| x.gsub!(/^\s/, "") }
    end       
  end

  def delete_nils(array)
    array.delete_if { |x| x == nil }
  end

  def scrape_shows
    @noisepop.css('ul li div p').each do |data|
      @shows << data.text.gsub!(/[\n]/, "")
    end
    clean_shows
  end

  def clean_shows
    delete_nils(@shows)   
    @shows.each do |x|
      x.gsub!(/\s{2}/, "").gsub!(/\(map\)/, "").split(' ')      
    end
  end

  def to_hash
    @hash = @shows.zip(@lineups)
    h1 = Hash[*@hash.flatten]
    h1.each do |k, v|      
      v.include?(',') ? v = v.split(',').each {|x| x.gsub!(/^\s/, "")} : v = v.split(/^/)
    end
            
    CSV.open("file.csv", "wb") do |csv|      
      csv << h1.values
    end        
  end

end # /class

noisepop = NoisePopScraper.new
noisepop.scrape_and_clean
