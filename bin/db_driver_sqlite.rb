# frozen_string_literal: true

require 'sqlite3'

# driver for sqlite
class DBDriverSqlite
  def initialize(memory: false)
    @db = if memory
            SQLite3::Database.new ':memory:'
          else
            SQLite3::Database.new 'datafile.db'
          end
  end

  def execute(command)
    @db.execute(command)
  end

  def reset
    tables = get_all_tables
    tables.each do |table|
      puts "Deleting table: #{table[0]}"
      @db.execute "DROP TABLE #{table[0]};"
    end
  end

  private

  def get_all_tables
    @db.execute "SELECT name FROM sqlite_master WHERE type='table';"
  end
end
