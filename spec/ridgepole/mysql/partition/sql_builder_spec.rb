require "spec_helper"

RSpec.describe Ridgepole::MySQL::Partition::SQLBuilder do
  describe "RangePartition" do
    let(:table_name) { "test" }
    let(:columns) { [:created_at] }
    let(:range) { Time.local(2000, 1, 1)..Time.local(2000, 1, 10) }
    let(:days) { 24 * 60 * 60 }
    let(:partition_parser) { Ridgepole::MySQL::Partition::RangeParser.new(between: range, interval: 5 * days) }

    subject { Ridgepole::MySQL::Partition::SQLBuilder.new(table_name, columns, partition_parser).to_sql }

    it "generates alter table" do

      expect(subject).to eq(
      <<-SQL
ALTER TABLE test PARTITION BY RANGE COLUMNS(created_at) (
PARTITION p20000106 VALUES LESS THAN ("2000-01-06 00:00:00") ENGINE=InnoDB,
PARTITION p20000110 VALUES LESS THAN ("2000-01-10 00:00:00") ENGINE=InnoDB
);
     SQL
     )
    end
  end
end
