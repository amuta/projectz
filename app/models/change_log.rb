class ChangeLog < ApplicationRecord
  belongs_to :recordable, polymorphic: true
  belongs_to :user, optional: true
  validates :changed_data, presence: true

  after_create_commit -> {
    broadcast_prepend_to(
      "project_#{recordable.id}_project",
      target: "project_#{recordable.id}",
      partial: "change_logs/change_log",
      locals: { change_log: self }
    )
  }
end
