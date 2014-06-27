module AutoSchema
  module Adapters
    class Table
      attr_reader :options, :columns
 
      def initialize options = {}
        @options = options
        @columns = {}
      end
 
      def column name, type, options = {}
        columns[name.to_s] = Column.new name, type, options
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