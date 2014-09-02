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
        index name, options.slice(:unique) if options[:index]
        @columns[name.to_s] = Column.new @name, name, type, options
      end

      def index name, options = {}
        @indexes.push Index.new @name, name, options
      end

      def timestamps
        column :created_at, :datetime
        column :updated_at, :datetime
      end

      def references name, options
        column :"#{name}_id", :integer, options
      end

      def attachement name
        column :"#{name}_file_name",    :string
        column :"#{name}_content_type", :string
        column :"#{name}_file_size",    :integer
        column :"#{name}_updated_at",   :datetime
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