require 'nokogiri'
require 'open-uri'

class BashParser

  attr_reader :posts #класс должен возвращать только посты в виде массива объектов

  def initialize
    @doc = Nokogiri::HTML open('http://bash.im/').read
    @doc.encoding = 'UTF-8'
    @posts = []
    fill_posts
  end

  Post = Struct.new(:number, :ratio, :date, :text)

  private

  def fill_posts
    @doc.css('div.quote').each do |quote_container|      
      unless quote_container.at_css('span.rating-o').nil? #пропускаем невидимый span-контейнер, не являющийся цитатой
       ratio = quote_container.at_css('span.rating-o').text.strip 
       ratio = nil if ratio == '...'       
       date = quote_container.at_css('span.date').text.strip
       number = quote_container.at_css('a.id').text.strip
       number = number.slice!(1,number.length) # удаляем символ диез из номера      
       text = quote_container.at_css('div.text').to_s #текст цитаты сохраняем с разметкой - она нужна для показа в будущем цитаты и форматирования.       
       @posts << Post.new(number,ratio,date,text)
      end                 
    end
  end
  
  
end