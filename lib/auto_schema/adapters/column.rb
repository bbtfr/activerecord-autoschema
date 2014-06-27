module AutoSchema
  module Adapters
    class Column
      attr_reader :name, :type, :options
 
      def initialize name, type, options={}
        @name = name
        @type = type
        @options = options
      end
      
      DATABASE_OPTIONS = [
        :default, :limit
      ]

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