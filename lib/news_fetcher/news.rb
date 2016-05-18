module NewsFetcher
  class News
    ATTRS = [:type, :forum, :forum_title, :discussion_title, :language,
          :gmt_offset, :topic_url, :topic_text, :spam_score, :post_num, :post_id,
          :post_url, :post_date, :post_time, :username, :post, :signature,
          :country, :main_image]

    attr_accessor :external_links, *ATTRS
    attr_reader :slug

    def self.slugify(url)
      path = url.split('://') # strip protocol
      path = path.size == 1 ? path[0] : path[1]
      path.downcase.gsub(/[^a-z0-9]+/, '-')
    end

    def [](sym)
      self.send(sym)
    end

    def []=(sym, value)
      self.send(:"#{sym}=", value)
    end

    def set_slug
      @slug = @post_url ? slugify(@post_url) : slugify(@topic_url)
    end

    def slugify(url)
      self.class.slugify(url)
    end

    def save
      # save to redis
    end
  end
end