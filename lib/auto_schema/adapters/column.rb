module AutoSchema
  module Adapters
    class Column
      attr_reader :table_name, :name, :type, :options
 
      def initialize table_name, name, type, options={}
        @table_name = table_name
        @name = name
        @type = type
        @options = options
      end
      
      DATABASE_OPTIONS = [
        :default, :limit, :null
      ]

      def create!
        ActiveRecord::Migration.add_column @table_name, @name, @type, @options
      end

      def remove!
        ActiveRecord::Migration.remove_column @table_name, @name
      end

      def compare column
        return false unless @type == column.type
        DATABASE_OPTIONS.each do |option|
          return false unless @options[option] == column.send(option)
        end
        return true
      end
    end
  end
end