require 'nokogiri'
require 'open-uri'

class NoisePopScraper

  attr_reader :lineups, :show_info

  def initialize
    @url = "http://schedule.noisepop.com/"    
    @noisepop = nokome(@url)
    @lineups = []
    @show_data = []
  end

  def nokome(url)
    Nokogiri::HTML(open(url))
  end

  def scrape_and_clean    
    scrape_lineups
    scrape_show_data
    to_hash
  end  

  def scrape_lineups
    clean_data = []

    @noisepop.css('ul li div h2 a').each do |element|
      @lineups << element.text.strip
      @lineups.each {|x| x.gsub!(/^\s/, "")}
    end

    # clean_data.each do |band|
      # if band.include?(',')
        # @lineups << band.split(',').each {|x| x.gsub!(/^\s/, "")}
      # end
    # end  
    # puts @lineups.inspect
  end

  def delete_nils(array)
    array.delete_if { |x| x == nil }
  end

  def scrape_show_data
    @noisepop.css('ul li div p').each do |element|
      @show_data << element.text.gsub!(/[\n]/, "")
    end

    delete_nils(@show_data)
    
    @show_data.each do |element|      
      element.gsub!(/\s{2}/, "")
      element.gsub!(/\(map\)/, "")
      element.split(' ')
    end
    # puts @show_data
  end

  # def clean_data(scraped_data)
  #   scraped_data.each do |element|
  #     element.strip
  #   end
  # end

  def to_hash
    @hash = @show_data.zip(@lineups)
    h1 = Hash[*@hash.flatten]
    h1.each do |k, v|
      puts "#{k} => #{v}"
    end
  end

end

noisepop = NoisePopScraper.new
noisepop.scrape_and_clean