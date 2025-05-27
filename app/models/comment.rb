class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :body, presence: true

  after_create_commit -> {
    broadcast_append_to(
      "project_#{project.id}_project",
      target: "project_#{project.id}",
      partial: "comments/comment",
      locals: { comment: self }
    )
  }
end
