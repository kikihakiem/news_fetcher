require 'test_helper'

describe NewsFetcher::Parser do
  describe 'parse_news' do
    subject { NewsFetcher::Parser.parse(xml) }

    it 'correctly parses news' do
      subject.type.must_equal 'mainstream'
      subject.forum.must_equal 'http://www.theverge.com/tag/concepts'
      subject.forum_title.must_equal 'Concepts | The Verge'
      subject.discussion_title.must_equal 'Samsung Notebook 9 review: redefining the thin-and-light'
      subject.language.must_equal 'english'
      subject.gmt_offset.must_equal nil
      subject.topic_url.must_equal 'http://www.theverge.com/2016/5/13/11667586/samsung-notebook-9-laptop-ultrabook-windows-review'
      subject.topic_text.must_equal 'Samsung’s new Notebook 9 bucks the trend: it’s a bonafide 15-inch computer that weighs less than three pounds. It’s thin enough to slip into a bag with ease, and it doesn’t compromise specs in the name of design. The $1,199 Notebook 9 has a Core i7 processor, 8GB of RAM, and 256GB of storage. It’s not a budget laptop by any means, but it also isn’t priced into the stratosphere, coming in around the price of a similarly specced 13-inch MacBook Air'
      subject.spam_score.must_equal '0.00'
      subject.post_num.must_equal '85'
      subject.post_id.must_equal 'post-85'
      subject.post_url.must_equal 'http://www.theverge.com/2016/5/13/11667586/samsung-notebook-9-laptop-ultrabook-windows-review'
      subject.post_date.must_equal '20160513'
      subject.post_time.must_equal '2057'
      subject.username.must_equal 'id4andrei'
      subject.post.must_equal 'This is a great overall ultrabook. Good specs and a 15" screen. Unfortunately Samsung cut on the battery to achieve a lower weight with the added effect of a hollow frame. Better deal than many 12"-13" ultraportables. Deserving of a higher score purely for the complete package, including price. Apple has a worse product in the Macbook and always gets better scores around here. No need to play the "victim".'
      subject.signature.must_equal ''
      subject.external_links.must_equal ['http://www.theverge.com/2015/5/13/11667109/samsung-galaxy-s9']
      subject.country.must_equal 'US'
      subject.main_image.must_equal 'https://cdn1.vox-cdn.com/thumbor/QuMsEA4zDG8FjhAbilPvqsZBS5Q=/0x131:1500x975/1600x900/cdn0.vox-cdn.com/uploads/chorus_image/image/49584199/akrales_160511_1054_A_0053.0.0.jpg'
    end
  end

  let(:xml) do
    %q[<?xml version="1.0" encoding="UTF-8"?>
    <document>
      <type>mainstream</type>
      <forum>http://www.theverge.com/tag/concepts</forum>
      <forum_title>Concepts | The Verge</forum_title>
      <discussion_title>Samsung Notebook 9 review: redefining the thin-and-light</discussion_title>
      <language>english</language>
      <gmt_offset></gmt_offset>
      <topic_url>http://www.theverge.com/2016/5/13/11667586/samsung-notebook-9-laptop-ultrabook-windows-review</topic_url>
      <topic_text>
      Samsung’s new Notebook 9 bucks the trend: it’s a bonafide 15-inch computer that weighs less than three pounds. It’s thin enough to slip into a bag with ease, and it doesn’t compromise specs in the name of design. The $1,199 Notebook 9 has a Core i7 processor, 8GB of RAM, and 256GB of storage. It’s not a budget laptop by any means, but it also isn’t priced into the stratosphere, coming in around the price of a similarly specced 13-inch MacBook Air
      </topic_text>
      <spam_score>0.00</spam_score>
      <post_num>85</post_num>
      <post_id>post-85</post_id>
      <post_url>http://www.theverge.com/2016/5/13/11667586/samsung-notebook-9-laptop-ultrabook-windows-review</post_url>
      <post_date>20160513</post_date>
      <post_time>2057</post_time>
      <username>id4andrei</username>
      <post>
      This is a great overall ultrabook. Good specs and a 15" screen. Unfortunately Samsung cut on the battery to achieve a lower weight with the added effect of a hollow frame. Better deal than many 12&quot;-13&quot; ultraportables. Deserving of a higher score purely for the complete package, including price.
      Apple has a worse product in the Macbook and always gets better scores around here. No need to play the &quot;victim&quot;.
      </post>
      <signature>

      </signature>
      <external_links>
        <external_link>http://www.theverge.com/2015/5/13/11667109/samsung-galaxy-s9</external_link>
      </external_links>
      <country>US</country>
      <main_image>https://cdn1.vox-cdn.com/thumbor/QuMsEA4zDG8FjhAbilPvqsZBS5Q=/0x131:1500x975/1600x900/cdn0.vox-cdn.com/uploads/chorus_image/image/49584199/akrales_160511_1054_A_0053.0.0.jpg</main_image>
    </document>
    ]
  end
end
