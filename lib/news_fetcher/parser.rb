require 'ox'

module NewsFetcher
  class SaxParser < Ox::Sax
    def initialize(&block)
      @yield_to = block
      @news = News.new
    end
    
    # start_element, end_element and value are implementation of Visitor Pattern
    # https://en.wikipedia.org/wiki/Visitor_pattern
    def start_element(name)
      @current_node = name
    end

    # value here is an object of Ox::Sax::Value, so we need to convert it to simple value
    # http://www.ohler.com/ox/Ox/Sax/Value.html
    def value(value)
      if News::ATTRS.include? @current_node
        @news[@current_node] = value.as_s.split.join(' ') # squish string
      elsif @current_node == :external_link
        @news.external_links ||= []
        @news.external_links << value.as_s
      end
    end

    def end_element(name)
      if name == :document
        @yield_to.call(@news)
      end
    end
  end

  class Parser
    def self.parse(xml)
      parser = SaxParser.new do |parsed|
        parsed.set_slug
        return parsed
      end

      Ox.sax_parse(parser, xml)
    end
  end
end