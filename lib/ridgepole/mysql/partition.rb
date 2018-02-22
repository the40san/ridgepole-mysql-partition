require "ridgepole/mysql/partition/version"

module Ridgepole
  module MySQL
    module Partition
      autoload :RangePartitionChecker, "ridgepole/mysql/partition/range_partition_checker"
      autoload :RangeParser, "ridgepole/mysql/partition/range_parser"
      autoload :SQLBuilder, "ridgepole/mysql/partition/sql_builder"
      autoload :DSLExtension, "ridgepole/mysql/partition/dsl_extension"
    end
  end
end

if defined?(Ridgepole::DSLParser::Context)
  Ridgepole::DSLParser::Context.include(Ridgepole::MySQL::Partition::DSLExtension)
end
