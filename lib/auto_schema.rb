require_relative 'auto_schema/adapters/column'
require_relative 'auto_schema/adapters/index'
require_relative 'auto_schema/adapters/table'

module AutoSchema
  extend ActiveSupport::Concern

  module ClassMethods
    def table options = {}
      table = Adapters::Table.new(table_name, options)
      yield table
 
      # Create table unless existed
      unless table_exists?
        table.create!
      end
 
      # Remove columns if undefined
      connection.columns(table_name).each do |exist_column|
        column_name = exist_column.name
        next if column_name == primary_key

        column = table.columns.delete column_name
        if column
          unless column.compare exist_column

          end
        else
          column.remove!
        end
      end
 
      # Create columns if defined
      table.columns.each do |_, non_exist_column|
        non_exist_column.create!
      end

      table.indexes.each do |index|
        index.create! unless index.exists?
      end

    end
  end

end

# include in AR
ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.send(:include, AutoSchema)
end