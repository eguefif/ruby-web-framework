task default: %w[run]

task :run do
  system('rackup ./bin/config.ru')
end

task :test do
  system('bundle exec rspec test')
end

namespace :db do
  task :migrate do
    sh 'ruby bin/make_migration.rb migrate'
  end

  task :reset do
    ruby 'bin/make_migration.rb', 'reset'
  end

  task :rollback do
    ruby 'bin/make_migration.rb', 'rollback'
  end
end
