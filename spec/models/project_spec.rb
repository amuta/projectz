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
end
