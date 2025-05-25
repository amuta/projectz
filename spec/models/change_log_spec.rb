require 'rails_helper'

RSpec.describe ChangeLog, type: :model do
  subject { build(:change_log) }

  it 'has a valid factory' do
    expect(subject).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:recordable) }
    it { is_expected.to belong_to(:user).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:changed_data) }
  end
end
