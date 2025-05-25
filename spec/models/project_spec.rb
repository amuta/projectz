require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { build(:project) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:change_logs).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it do
      should define_enum_for(:status).
        with_values([:draft, :active, :on_hold, :completed, :cancelled]).
        backed_by_column_of_type(:integer)
    end
  end

  context 'on auditable' do
    it 'saves changelog when status is changed' do
      project = create(:project, status: :draft)
      expect {
        project.update(status: :active)
      }.to change { project.change_logs.count }.by(1)

      change_log = project.change_logs.last
      expect(change_log.changed_data).to include("status" => ["draft", "active"])
    end

    it 'saves changelog when comment is added' do
      project = create(:project)
      expect {
        project.comments.create(body: 'New comment', user: create(:user))
      }.to change { project.change_logs.count }.by(1)

      change_log = project.change_logs.last
      expect(change_log.changed_data).to include("comments" => ["", "New comment"])
    end
  end
end
