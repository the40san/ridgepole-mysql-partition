module Ridgepole
  module MySQL
    module Partition
      module DSLExtension
        def range_partition(table_name, columns:, between:, interval:)
          range_parser = RangeParser.new(between: between, interval: interval)
          range_partition_checker = RangePartitionChecker.new(table_name, range_parser)
          sql_builder = SQLBuilder.new(table_name, columns, range_parser)

          execute(sql_builder.to_sql) do |c|
            # execute only if you need to update partition
            range_partition_checker.can_apply?(c)
          end
        end
      end
    end
  end
end
