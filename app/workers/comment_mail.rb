class CommentMail
  @queue = :comments_queue

  def self.perform(comment_id)
    CommentMailer.comment_notification(comment_id).deliver
  end
end

