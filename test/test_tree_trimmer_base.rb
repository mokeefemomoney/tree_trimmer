require_relative 'minitest_helper'

TreeTrimmer::Base.class_eval do
  def branches
    ["branch-one", "branch-two"]
  end
end

class TestTreeTrimmerBase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TreeTrimmer::VERSION
  end

  def test_trim_branches_returns_the_branches_deleted
    Downup::Base.set_prompt_return(["branch-one"])
    stdin = FakeStdin.new(["q", "n"])
    subject = TreeTrimmer::Base.new(
      stdin: stdin, stdout: FakeStdout.new
    )

    do_not_delete_branches_in_test!
    result = subject.trim_branches
    assert_equal result, ["branch-one"]
  end

  private

  def do_not_delete_branches_in_test!
    TreeTrimmer::Base.class_eval do
      def delete_branches!
      end
    end
  end
end
