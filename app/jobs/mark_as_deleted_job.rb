class MarkAsDeletedJob < ApplicationJob
  include ActionView::RecordIdentifier
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    post.update(deleted: true)

    Turbo::StreamsChannel.broadcast_remove_to("posts", target: dom_id(post))
  end
end
