module Deletable
  extend ActiveSupport::Concern

  included do
    attr_accessor :expires_in
    after_create :schedule_deletion
  end

  private

  def schedule_deletion
    return unless expires_in.present?

    expires_at = Time.current + expires_in.to_i.seconds
    self.update_column(:expires_at, expires_at)

    MarkAsDeletedJob.set(wait_until: expires_at).perform_later(id)
  end
end
