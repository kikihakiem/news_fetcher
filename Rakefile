require 'bundler/gem_tasks'
require 'rake/testtask'
require 'news_fetcher'
require 'redis'

Rake::TestTask.new(:spec) do |t|
  t.libs << "spec"
  t.libs << "lib"
  t.test_files = FileList['spec/**/*_spec.rb']
end

desc 'Sample task to run'
task :fetch do
  NewsFetcher.each_news('http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/') do |md5_hash, xml|
    unless NewsFetcher.save_to_redis(md5_hash, xml)
      p "News #{md5_hash}.xml already imported"
    end
  end
end

task :default => :spec
