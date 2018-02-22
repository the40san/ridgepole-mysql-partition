module Ridgepole
  module MySQL module Partition
      class RangeParser
        class TransparentValueParser
          def parse_as_partition_name(value)
            "p#{value}"
          end

          def parse_as_value(value)
            value
          end
        end

        class TimeValueParser
          def parse_as_partition_name(time)
             time.strftime("p%Y%m%d")
          end

          def parse_as_value(time)
             time.strftime("%Y-%m-%d %H:%M:%S")
          end
        end

        def initialize(between:, interval:)
          @between = between
          @interval = interval
        end

        def alter_keyword
          "PARTITION BY RANGE"
        end

        def partition_string
          range_to_array.map do |pname, pvalue|
            "PARTITION #{pname} VALUES LESS THAN (\"#{pvalue}\") ENGINE=InnoDB"
          end.join(",\n")
        end

        def partition_names
          range_to_array.map(&:first)
        end

        private

        def value_parser
          @_value_parser ||=
            begin
              return TimeValueParser.new if @between.first.is_a?(Time)
              TransparentValueParser.new
            end
        end

        def range_to_array
          # Do not use slice_each or else for Time
          start_at = @between.first
          end_at = @between.last

          [].tap do |result|
            iter = start_at
            loop do
              iter = [iter + @interval, end_at].min

              result << [
                value_parser.parse_as_partition_name(iter.dup),
                value_parser.parse_as_value(iter.dup)
              ]

              break if iter >= end_at
            end
          end
        end
      end
    end
  end
end
