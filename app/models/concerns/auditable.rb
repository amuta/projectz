module Auditable
    extend ActiveSupport::Concern
  
    included do
      has_many :change_logs, as: :recordable, dependent: :destroy
  
      after_update :log_audit_record
    end
  
    private
  
    def log_audit_record
      diff = previous_changes.except('updated_at', 'created_at')
      return if diff.empty?
  
      change_logs.create!(
        changed_data: diff,
        user: Current.user
      )
    end
  end
  