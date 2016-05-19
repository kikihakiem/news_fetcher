$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'news_fetcher'

require 'minitest/autorun'
require 'minitest/spec'

require 'byebug'
require 'fakeredis/minitest'