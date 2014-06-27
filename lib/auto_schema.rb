require 'auto_schema/adapters/column'
require 'auto_schema/adapters/table'

module AutoSchema
  extend ActiveSupport::Concern

  module ClassMethods
    def table options = {}
      table = Adapters::Table.new(options)
      yield table
 
      # Create table unless existed
      unless table_exists?
        ActiveRecord::Migration.create_table table_name
      end
 
      # Remove columns if undefined
      connection.columns(table_name).each do |existe_column|
        column_name = existe_column.name
        next if column_name == "id"

        column = table.columns.delete column_name
        if column
          unless column.compare existe_column

          end
        else
          ActiveRecord::Migration.remove_column table_name, column_name
        end
      end
 
      # Create columns if defined
      table.columns.each do |column_name, non_existe_column|
        ActiveRecord::Migration.add_column table_name, column_name, 
          non_existe_column.type, non_existe_column.options
      end

    end
  end

end

# include in AR
ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.send(:include, AutoSchema)
end