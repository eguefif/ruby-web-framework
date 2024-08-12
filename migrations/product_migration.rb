require './bin/sql_command_generator'

# Migrations for product table
class ProductMigration
  def initialize(db)
    @db = db
    @migration_id = 1
    @name = 'products'
    @cols = [
      { 'name' => 'name', 'type' => 'varchar', 'size' => 40 },
      { 'name' => 'quantity', 'type' => 'int', 'size' => 40 },
      { 'name' => 'description', 'type' => 'text' }
    ]
    @migration_type = :create_table
    @rollback_type = :drop_table
  end

  def make_migration
    puts "Making migration : #{@migration_id}"
    if @cols.length.positive?
      @db.send(@migration_type, @name, @cols)
    else
      @db.send(@migration_type, @name)
    end
  end

  def rollback
    puts "Rollingback from migration : #{@migration_id}"
    if @cols.length.positive?
      @db.send(@rollback_type, @name, @cols)
    else
      @db.send(@rollback_type, @name)
    end
  end
end
