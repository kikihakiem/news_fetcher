require 'bundler/gem_tasks'
require 'rake/testtask'
require 'news_fetcher'

Rake::TestTask.new(:spec) do |t|
  t.libs << "spec"
  t.libs << "lib"
  t.test_files = FileList['spec/**/*_spec.rb']
end

desc 'Sample task to run'
task :sample do
  NewsFetcher.each_news('http://feed.omgili.com/5Rh5AMTrc4Pv/mainstream/posts/') do |news|
    puts news.id
  end
end

task :default => :spec
