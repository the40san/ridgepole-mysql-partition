module Ridgepole
  module MySQL
    module Partition
      class RangePartitionChecker
        def initialize(table_name, range_parser)
          @table_name = table_name
          @applying_partition_names = range_parser.partition_names
        end

        # Require information_schema read access
        def can_apply?(connection)
          raw_connection = connection.raw_connection

          db_name = raw_connection.query_options[:database]
          query_string = query(db_name)

          embbed_partition = raw_connection.query(query_string).each.flatten
          embbed_partition != @applying_partition_names
        end

        private

        def query(db_name)
          query = <<-SQL
SELECT PARTITION_NAME FROM information_schema.PARTITIONS
WHERE TABLE_SCHEMA = '#{db_name}'
AND TABLE_NAME = '#{@table_name}'
AND PARTITION_NAME IS NOT NULL
          SQL
        end
      end
    end
  end
end
