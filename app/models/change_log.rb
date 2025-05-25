class ChangeLog < ApplicationRecord
  belongs_to :recordable, polymorphic: true
  belongs_to :user
end
