Dir['./migrations/*.rb'].each { |file| require file }
require './bin/db_driver_sqlite'
require './bin/db_engine'

# Migrations tools
class MigrationsMaker
  def initialize
    @db = DBEngine.new(DBDriverSqlite.new(memory: false))
    @migrations = [ProductMigration.new(@db)]
  end

  def make_migrations
    @migrations.each do |migration|
      migration.make_migration
    end
  end

  def rollback
    @migrations.each do |migration|
      migration.rollback
    end
  end

  def reset_db
    puts 'Reseting database'
    @db.reset
  end
end

migration_maker = MigrationsMaker.new
command = ARGV[0]
puts "Entering in migration tools with command: #{command}"
if ARGV.length.positive?
  case command
  when 'migrate'
    puts 'Making migrations'
    migration_maker.make_migrations
  when 'rollback'
    migration_maker.rollback
  when 'reset'
    migration_maker.reset_db
  end
else
  migration_maker.make_migrations
end
