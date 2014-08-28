module AutoSchema
  module Adapters
    class Table
      attr_reader :name, :options, :columns, :indexes
 
      def initialize name, options = {}
        @name = name
        @options = options
        @columns = {}
        @indexes = []
      end
 
      def create!
        ActiveRecord::Migration.create_table @name
      end

      def column name, type, options = {}
        index name if options[:index]
        @columns[name.to_s] = Column.new @name, name, type, options
      end

      def index name
        @indexes << Index.new @name, name 
      end

      def timestamps
        column :created_at, :datetime
        column :updated_at, :datetime
      end

      DATABASE_TYPES = [
        :string, :text, :integer, :float, :decimal, 
        :datetime, :time, :date, :binary, :boolean
      ]

      DATABASE_TYPES.each do |type|
        define_method type do |name, options = {}|
          column name, type, options
        end
      end
    end
  end
end