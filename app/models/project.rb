class Project < ApplicationRecord
  include Auditable

  has_many :comments, dependent: :destroy

  enum :status, { draft: 0, active: 1, on_hold: 2, completed: 3, cancelled: 4 }

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }

  after_create :comment_creation

  private

  def comment_creation
    comments.create!(
      body: "Project created",
      user: Current.user
    )
  end
end
