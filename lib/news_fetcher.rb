require 'news_fetcher/version'
require 'news_fetcher/downloader'
require 'news_fetcher/extractor'

module NewsFetcher
  def self.each_news(http_folder, max_zip_file = nil, max_news_count = nil)
    news_count = 0
    Downloader.each_zip(http_folder, max_zip_file) do |zip_file_path|
      Extractor.each_xml(zip_file_path) do |filename, xml|
        yield [strip_extension(filename), xml]

        news_count += 1
        break if max_news_count && news_count >= max_news_count
      end
    end

    news_count
  end

  def self.strip_extension(filename)
    filename.split('.').first
  end

  def self.save_to_redis(md5_hash, xml)
    redis = Redis.current
    existed = !redis.sadd('NEWS_XML_UNIQ', md5_hash)

    return false if existed 

    redis.lpush('NEWS_XML', xml)
  end
end
