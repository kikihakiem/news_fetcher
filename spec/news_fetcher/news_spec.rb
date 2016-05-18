require 'test_helper'

describe NewsFetcher::News do
  describe 'slugify' do
    subject { NewsFetcher::News.slugify(url) }

    describe 'when url contains protocol' do
      let(:url) { 'http://www.theverge.com/2015/5/13/11667109/samsung-galaxy-s9' }

      it 'slugifies url correctly' do
        subject.must_equal 'www-theverge-com-2015-5-13-11667109-samsung-galaxy-s9'
      end
    end

    describe 'when url doesnt contain protocol' do
      let(:url) { 'www.theverge.com/2015/5/13/11667109/samsung-galaxy-s9' }

      it 'slugifies url correctly' do
        subject.must_equal 'www-theverge-com-2015-5-13-11667109-samsung-galaxy-s9'
      end
    end
  end
end
