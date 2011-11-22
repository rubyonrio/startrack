require 'test_helper'

class CommentMailerTest < ActionMailer::TestCase
  tests CommentMailer

  def setup
    @comment = comments(:one)
    @watcher = tasks(:room_galaxy).watchers.first
    @commment_notification = CommentMailer.comment_notification(@watcher, @comment)
  end

  test "comment notification" do
    assert_equal ["startrack@example.com.br"], @commment_notification.from
    assert_equal ["kirk@example.com"], @commment_notification.to
    assert_equal "[First Journey] Spok made a new comment on #587127017 - Create Enterprise", @commment_notification.subject
    assert_equal "text/plain; charset=UTF-8", @commment_notification.content_type
    assert_equal read_fixture('comment_notification').join, @commment_notification.body.to_s
  end
end
