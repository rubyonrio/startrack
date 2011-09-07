require 'test_helper'

class CommentMailerTest < ActionMailer::TestCase
  tests CommentMailer

  def setup
    @comment = comments(:one)
    @task = tasks(:one)
    @watcher = @task.watchers.first
  end

  test "comment notification" do
    @expected.from    = 'me@example.com'
    @expected.to      = 'friend@example.com'
    @expected.subject = "[Projeto teste] New comment on #28 - Escrever testes"
    @expected.body    = read_fixture('body')
    @expected.date    = Time.now
 
    assert_equal @expected.encoded, CommentMailer.comment_notification(@watcher, @comment).encoded
  end
end
