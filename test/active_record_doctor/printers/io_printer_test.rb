require 'test_helper'

# Load all tasks
Dir["#{File.dirname(__FILE__)}/../../../lib/active_record_doctor/tasks/*.rb"].each { |f| require f }
require 'active_record_doctor/printers/io_printer'

class ActiveRecordDoctor::Printers::IOPrinterTest < ActiveSupport::TestCase
  def test_all_tasks_have_printers
    ActiveRecordDoctor::Tasks::Base.subclasses.each do |task_class|
      name = task_class.name.demodulize.underscore.to_sym

      assert(
        ActiveRecordDoctor::Printers::IOPrinter.method_defined?(name),
        "IOPrinter should define #{name}"
      )
    end
  end

  def test_unindexed_foreign_keys
    assert_equal(<<EOF, unindexed_foreign_keys({ "users" => ["profile_id", "account_id"], "account" => ["group_id"] }))
account group_id
users account_id profile_id
EOF
  end

  private

  def unindexed_foreign_keys(argument)
    io = StringIO.new
    ActiveRecordDoctor::Printers::IOPrinter.new(io).unindexed_foreign_keys(argument)
    io.string
  end
end
