module Ridgepole
  module MySQL module Partition
      class SQLBuilder
        def initialize(table_name, columns, partition_parser)
          @table_name = table_name
          @columns = columns.is_a?(Array) ? columns : [columns]
          @partition_parser = partition_parser
        end

        def to_sql
          <<-SQL
ALTER TABLE #{@table_name} #{@partition_parser.alter_keyword} COLUMNS(#{@columns.join(",")}) (
#{@partition_parser.partition_string}
);
          SQL
        end
      end
    end
  end
end
