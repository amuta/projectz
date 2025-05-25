class ChangeLog < ApplicationRecord
  belongs_to :recordable, polymorphic: true
  belongs_to :user, optional: true
  validates :changed_data, presence: true
end
