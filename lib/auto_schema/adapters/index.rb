module AutoSchema
  module Adapters
    class Index
      attr_reader :table_name, :name
 
      def initialize table_name, name
        @table_name = table_name
        @name = name
      end

      def exists?
        ActiveRecord::Migration.index_exists? @table_name, @name
      end

      def create!
        ActiveRecord::Migration.create_index @table_name, @name
      end
     
    end
  end
end