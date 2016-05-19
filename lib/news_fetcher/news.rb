require 'json'

module NewsFetcher
  class News
    ATTRS = [:type, :forum, :forum_title, :discussion_title, :language,
          :gmt_offset, :topic_url, :topic_text, :spam_score, :post_num, :post_id,
          :post_url, :post_date, :post_time, :username, :post, :signature,
          :country, :main_image]

    attr_accessor :hash, :external_links, *ATTRS

    def [](sym)
      self.send(sym)
    end

    def []=(sym, value)
      self.send(:"#{sym}=", value)
    end

    def hash=(filename)
      @hash = filename.split('.').first
    end

    def to_json
      hsh = (ATTRS + [:hash, :external_links]).reduce({}) do |result, attribute|
        result[attribute] = self.send(attribute) if self.send(attribute)
        result
      end

      JSON.dump(hsh)
    end

    def save
      # save to redis
    end
  end
end