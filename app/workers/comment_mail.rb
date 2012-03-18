class CommentMail
  @queue = :comments_queue

  def self.perform(comment_id)
    CommentMailer.comment_notification(@comment.id).deliver
  end
end

