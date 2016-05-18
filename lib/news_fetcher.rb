require 'news_fetcher/version'
require 'news_fetcher/downloader'
require 'news_fetcher/extractor'
require 'news_fetcher/parser'
require 'news_fetcher/news'

module NewsFetcher
  def self.each_news(http_folder, max_zip_file = 1, max_news_count = 10)
    news_count = 0
    Downloader.each_zip(http_folder, max_zip_file) do |zip_file|
      Extractor.each_xml(zip_file) do |id, xml|
        news = Parser.parse(xml)
        news.id = id
        yield news

        news_count += 1
        break if news_count >= max_news_count
      end
    end
  end
end
