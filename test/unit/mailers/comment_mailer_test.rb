require 'test_helper'

class CommentMailerTest < ActionMailer::TestCase
  tests CommentMailer

  def setup
    @comment = comments(:one)
    @watcher = tasks(:one).watchers.first
    @commment_notification = CommentMailer.comment_notification(@watcher, @comment)
  end

  test "comment notification" do
    assert_equal ["startrack@example.com.br"], @commment_notification.from
    assert_equal ["star@example.com"], @commment_notification.to
    assert_equal "[ProjectOne] New comment on #980190962 - My Task", @commment_notification.subject
    assert_equal "text/plain; charset=UTF-8", @commment_notification.content_type
    assert_equal read_fixture('comment_notification').join, @commment_notification.body.to_s
  end
end
