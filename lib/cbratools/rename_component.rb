module Cbratools
  class RenameComponent
    def initialize(current_name, new_name, path, verbose_output)
      @current_name = current_name
      @new_name = new_name
      @path = path
      @verbose_output = verbose_output

      @name_changes = [
          [current_name, new_name],
          [Cbratools::String.underscore(current_name),
           Cbratools::String.underscore(new_name)]
      ]
    end

    def run
      change_component_name_in_files
      change_component_name_in_folder_names
      change_component_name_in_file_names
    end

    def change_component_name_in_files
      selectors = [
      ->(filename) { !File.directory?(filename) },
      ->(filename) { !filename.include?(".log") },
      ->(filename) { !filename.include?(".sqlite") },
      ->(filename) { !filename.include?("schema.rb") },
      ->(filename) { !filename.include?("structure.sql") },
      ->(filename) { !filename.include?("sprockets") },
      ->(filename) { !filename.include?("tmp/cache") },
      ->(filename) { !filename.include?("assets/images") },
      ->(filename) { !filename.include?("db/migrate") }
      ]

      FilesAndFoldersSelector.new(@path, @name_changes, selectors).each do |f|
        FileRefactorer.new(f, @name_changes).refactor
      end
    end

    def change_component_name_in_folder_names
      selectors = [
      ->(filename) { File.directory?(filename) },
      ->(filename) { filename.end_with?(@name_changes.last.first) }
      ]
      FilesAndFoldersSelector.new(@path, @name_changes, selectors).each do |f|
        FolderRenamer.new(f, @name_changes).refactor
      end
    end

    def change_component_name_in_file_names
      selectors = [
      ->(filename) { !File.directory?(filename) },
      ->(filename) { !filename.include?("db/migrate") },
      ->(filename) { File.split(filename).last.include?(@name_changes.last.first) }
      ]
      FilesAndFoldersSelector.new(@path, @name_changes, selectors).each do |f|
        FilesRenamer.new(f, @name_changes).refactor
      end
    end

    class FilesAndFoldersSelector
      def initialize(path, name_changes, selectors)
        @path = path
        @name_changes = name_changes
        @selectors = selectors
      end

      def each
        all.each { |a| yield a }
      end

      private

      def all
        Dir.glob(@path + "/**/*").select do |filename|
          @selectors.all? { |selector| selector.call(filename) }
        end.sort do |a, b|
          b.length <=> a.length
        end
      end
    end

    class FileRefactorer
      def initialize(file, name_changes)
        @file = file
        @name_changes = name_changes
      end

      def refactor()
        file = File.read(@file)
        @name_changes.each do |name_change|
          file = file.gsub(name_change.first, name_change.last)
        end
        File.open(@file, "w") do |f|
          f.write(file)
        end
      end
    end

    class FolderRenamer
      def initialize(folder, name_changes)
        @folder = folder
        @name_changes = name_changes
      end

      def refactor
        new_folder = @folder.gsub(/#{@name_changes.last.first}$/, @name_changes.last.last)
        FileUtils.move(@folder, new_folder)
      end
    end

    class FilesRenamer
      def initialize(file, name_changes)
        @file = file
        @name_changes = name_changes
      end

      def refactor
        file = File.split(@file)
        new_file_name = file.last.gsub(/#{@name_changes.last.first}/, @name_changes.last.last)
        new_file = File.join(file.first, new_file_name)
        FileUtils.move(@file, new_file)
      end
    end
  end
end