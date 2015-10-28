module Cbratools
  class ComponentNameChangeMigrations
    def initialize(current_name, new_name, migrations_path, db_state_file)
      @current_name = current_name
      @new_name = new_name
      @migrations_path = migrations_path
      @db_state_file = db_state_file

      @name_changes = [
          [current_name, new_name],
          [Cbratools::String.underscore(current_name),
           Cbratools::String.underscore(new_name)]
      ]
    end

    def add
      file = File.read(@db_state_file)
      p file
      tables = []
      file.each_line do |line|
        tables << find_all_potential_table_names(line)
      end
      component_tables = tables.compact.select do |table|
        table.start_with?(@name_changes.last.first)
      end
      component_tables.each do |component_table|
        p component_table
        table_name = component_table.gsub("#{@name_changes.last.first}_", "")
        migration_name = Time.now.strftime("%Y%m%d%H%M%S") + migration_title(table_name)
        filename = File.join(@migrations_path, Cbratools::String.underscore(migration_name)) + ".rb"
        File.open(filename, "w") do |f|
          f.write(migration_content(table_name))
        end
      end
    end

    def find_all_potential_table_names(line)
      result = /create_table (?:"|')([^"']+)(?:"|')/.match line
      result && result[1]
    end

    private

    def migration_title(table_name)
      table_name = Cbratools::String.camelcase(table_name)
      "Move#{table_name}From#{@name_changes.first.first}To#{@name_changes.first.last}"
    end

    def migration_content(table_name)
      "class #{migration_title(table_name)} < ActiveRecord::Migration
  def change
    rename_table :#{@name_changes.last.first}_#{table_name}, :#{@name_changes.last.last}_#{table_name}
  end
end
"
    end
  end
end