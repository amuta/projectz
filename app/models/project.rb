class Project < ApplicationRecord
    include Auditable

    has_many :comments, dependent: :destroy

    enum :status, { draft: 0, active: 1, on_hold: 2, completed: 3, cancelled: 4 }
end
