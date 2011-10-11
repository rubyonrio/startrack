require 'test_helper'

class TaskMailerTest < ActionMailer::TestCase
  tests TaskMailer

  def setup
    @task = tasks(:create_enterprise)
    @watcher = tasks(:create_enterprise).watchers.first
    @changes = tasks(:create_enterprise).type
    @task_notification = TaskMailer.task_notification(@watcher, @task, @changes, @watchers_changes)
  end

  test "comment notification" do
    assert_equal ["startrack@example.com.br"], @task_notification.from
    assert_equal ["kirk@example.com"], @task_notification.to
    assert_equal "[First Journey] The task #587127017 - Create Enterprise has been updated", @task_notification.subject
    assert_equal "text/plain; charset=UTF-8", @task_notification.content_type
    assert_equal read_fixture('task_notification').join, @task_notification.body.to_s
    #TODO: test task.changes
  end
end
